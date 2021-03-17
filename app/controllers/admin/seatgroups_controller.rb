class Admin::SeatgroupsController < ApplicationController
  before_action :if_not_admin
  layout "admin"

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
  
end