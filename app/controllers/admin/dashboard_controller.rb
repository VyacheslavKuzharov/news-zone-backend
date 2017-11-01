module Admin
  class DashboardController < Admin::AdminController
    def index
      @qwer = current_user.inspect
    end
  end
end