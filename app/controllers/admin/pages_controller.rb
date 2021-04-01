class Admin::PagesController < ApplicationController
  before_action :if_not_admin
  layout "admin/admin"

end
