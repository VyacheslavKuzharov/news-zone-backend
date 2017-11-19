module Api
  class AuthenticationController < Api::ApiBaseController
    skip_before_action :authenticate_user!, only: [:authenticate, :create]


    def authenticate
      result = AuthUserService.call(authenticate_params)
      authentication_response(result)
    end

    def create
      result = RegisterUserService.call(register_params)
      authentication_response(result)
    end

    def logout
      current_user.update!(jti: nil)

      render json: {message: 'Sign out successfully!'}, status: :ok
    rescue => e
      render json: {message: e.message}, status: :unprocessable_entity
    end

    private

    def authentication_response(result)
      if result.ok?
        success_response!(result.user, AuthUserSerializer, auth_token: result.token)
      else
        throw_error!(type_for(result.error.type), message: result.error.messages.to_h.to_json)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def authenticate_params
      params.require(:user).permit(:email, :password)
    end
  end
end