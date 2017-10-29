module Users
  class RegistrationsController < Devise::RegistrationsController

    # GET /resource/sign_up
    def new
      redirect_to new_user_session_path
    end
  end
end