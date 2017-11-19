class AuthUserService < BaseService
  define_model_callbacks :initialize, only: :after
  after_initialize :valid?

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'is not an email!' },
            presence: true

  validates :password,
            length: 6..20

  attr_reader :email, :password

  AuthenticateUserError =  Class.new(StandardError)

  def initialize(params)
    run_callbacks :initialize do
      @email = params[:email]
      @password = params[:password]
    end
  end

  def call
    raise_exceptions!
    detect_user!

    jti = SecureRandom.hex(10)
    @user.jti = jti
    @user.save!

    respond_with(success_payload(@user, jti))
  rescue => e
    err = errors.messages
    err.merge!(message: e.message) if err.blank?

    respond_with(error_payload({messages: err, type: e.class}))
  end


  private

  def detect_user!
    @user = User.find_by!(email: email)

    unless @user.valid_password?(password)
      raise AuthenticateUserError, 'invalid credentials'
    end
  end

  def raise_exceptions!
    unless errors.messages.blank?
      raise AuthenticateUserError, errors.messages
    end
  end
end