module Users
  class SessionsController < Devise::SessionsController
    respond_to :html, :json


    def after_sign_in_path_for(resource)
      stored_location_for(resource) ||
        if resource.is_a?(User) && resource.admin?
          admin_root_path
        else
          super
        end
    end
  end
end