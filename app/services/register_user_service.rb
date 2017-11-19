class RegisterUserService < BaseService
  define_model_callbacks :initialize, only: :after
  after_initialize :valid?

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'is not an email!' },
            presence: true, uniqueness: { case_sensitive: false, model: User }

  validates :password,
            confirmation: true,
            length: 6..20


  attr_reader :email, :password, :password_confirmation

  RegisterUserError =  Class.new(StandardError)


  def initialize(params)
    run_callbacks :initialize do
      @email = params[:email]
      @password = params[:password]
      @password_confirmation = params[:password_confirmation]
    end
  end

  def call
    raise_exceptions!

    jti = SecureRandom.hex(10)
    user = User.create(
                    jti: jti,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation)

    respond_with(success_payload(user, jti))
  rescue => e
    exception = {messages: errors.messages, type: e.class}
    respond_with(error_payload(exception))
  end


  private

  def raise_exceptions!
    unless errors.messages.blank?
      raise RegisterUserError, errors.messages
    end
  end
end