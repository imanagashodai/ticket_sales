class Admin::GroundsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_grounds
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @ground = Ground.new
  end
  
  def edit
    @ground = Ground.find(params[:id])
  end
  
  def create
    @ground = Ground.new(ground_params)
    if @ground.save
      redirect_to admin_grounds_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @ground = Ground.find(params[:id])
    if @ground.update(ground_params)
      redirect_to admin_grounds_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @ground = Ground.find(params[:id])
    if @ground.destroy
      redirect_to admin_grounds_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_grounds_id] = params[:s_grounds_id]
    session[:s_grounds_name] = params[:s_grounds_name]
    session[:s_grounds_created_at] = params[:s_grounds_created_at]
    session[:s_grounds_updated_at] = params[:s_grounds_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_grounds_id)
    session.delete(:s_grounds_name)
    session.delete(:s_grounds_created_at)
    session.delete(:s_grounds_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def ground_params
      params.require(:ground).permit(:name)
    end
    
    def selected_grounds
      params[:order] ||= "id"
      @grounds = Ground.selector("id", session[:s_grounds_id]).includer("name", session[:s_grounds_name]).created_selector(session[:s_grounds_created_at]).updated_selector(session[:s_grounds_updated_at]).order(params[:order])
      @ground_columns = Ground.column_names
    end
    
end
