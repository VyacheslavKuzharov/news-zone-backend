class BaseService
  include JWTWrapper
  include ActiveModel::Validations
  include ActiveModel::Callbacks

  def self.call(*args)
    new(*args).call
  end

  private

  def respond_with(hash)
    Dish(hash)
  end

  def success_payload(user, jti)
    {
        ok: true,
        error: nil,
        user: user,
        token: JWTWrapper.encode({ user_id: user.id, jti: jti })
    }
  end

  def error_payload(error)
    {
        ok: false,
        error: error,
        user: nil,
        token: nil
    }
  end
end