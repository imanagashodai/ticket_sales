class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :selected_users
  
  layout "admin/admin"
  
  def index
  end
  
  def destroy
    if Blockeduser.create(user_id: params[:id])
      redirect_to admin_users_path, info: "ブロック完了"
    else
      flash.now[:danger] = "ブロック失敗"
      render :index
    end
  end
  
  def search
    session[:s_users_id] = params[:s_users_id]
    session[:s_users_name] = params[:s_users_name]
    session[:s_users_email] = params[:s_users_email]
    session[:s_users_created_at] = params[:s_users_created_at]
    session[:s_users_updated_at] = params[:s_users_updated_at]
    session[:s_users_admin] = params[:s_users_admin]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_users_id)
    session.delete(:s_users_name)
    session.delete(:s_users_email)
    session.delete(:s_users_created_at)
    session.delete(:s_users_updated_at)
    session.delete(:s_users_admin)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def selected_users
      params[:order] ||= "id"
      @users = User.selector("id", session[:s_users_id]).includer("name", session[:s_users_name]).includer("email", session[:s_users_email]).includer("created_at", session[:s_users_created_at]).includer("updated_at", session[:s_users_updated_at]).selector("admin", session[:s_users_admin]).order(params[:order])
      @user_columns = ["id", "name", "email", "created_at", "updated_at", "admin"]
    end
    
end
