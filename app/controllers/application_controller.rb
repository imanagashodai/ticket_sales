class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
  
  private
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end
  
end
