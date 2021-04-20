class Admin::BlockedusersController < ApplicationController
  before_action :if_not_admin
  before_action :selected_blockedusers
  
  layout "admin/admin"
  
  def index
  end
  
  def destroy
    if Blockeduser.find(params[:id]).destroy
      redirect_to admin_blockedusers_path, info: "ブロック解除完了"
    else
      flash.now[:danger] = "ブロック解除失敗"
      render :index
    end
  end
  
  def search
    session[:s_blockedusers_id] = params[:s_blockedusers_id]
    session[:s_blockedusers_user_id] = params[:s_blockedusers_user_id]
    session[:s_blockedusers_created_at] = params[:s_blockedusers_created_at]
    session[:s_blockedusers_updated_at] = params[:s_blockedusers_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_blockedusers_id)
    session.delete(:s_blockedusers_user_id)
    session.delete(:s_blockedusers_created_at)
    session.delete(:s_blockedusers_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def selected_blockedusers
      @id = params[:s_id]
      @user_id = params[:s_user_id]
      @created_at = params[:s_created_at]
      @updated_at = params[:s_updated_at]
      params[:order] ||= "id"
      @blockedusers = Blockeduser.selector("id", session[:s_blockedusers_id]).selector("user_id", session[:s_blockedusers_user_id]).created_selector(session[:s_blockedusers_created_at]).updated_selector(session[:s_blockedusers_updated_at]).order(params[:order])
    end
    
end
