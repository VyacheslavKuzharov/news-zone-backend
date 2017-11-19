module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        return fail! unless claims
        return fail! if user.nil?

        env['devise.skip_trackable'] = true
        success! user
      end

      def store?
        false
      end

      def user
        @user ||= User.find_by_jti claims['jti']
      end

      protected

      def claims
        strategy, token = request.headers['Authorization'].split(' ')

        return nil if (strategy || '').downcase != 'bearer'
        JWTWrapper.decode(token) rescue nil
      end
    end
  end
end
