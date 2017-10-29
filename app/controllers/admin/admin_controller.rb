module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin!



    private

    def authenticate_admin!
      unless user_signed_in? && current_user.admin?
        flash[:alert] = 'You do not have permission to view this page.'
        redirect_to new_user_session_path
      end
    end
  end
end