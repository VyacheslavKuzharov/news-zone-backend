module JWTWrapper
  extend self

  def encode(payload, expiration = nil)
    expiration ||= ENV['JWT_EXPIRATION_HOURS']

    payload = payload.dup
    payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def decode(token)
    decoded_token = JWT.decode(token, ENV['JWT_SECRET'])
    decoded_token.first
  rescue
    nil
  end
end