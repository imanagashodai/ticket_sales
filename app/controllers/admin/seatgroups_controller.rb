class Admin::SeatgroupsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_seatgroups
  before_action :set_ground, only: [:index, :edit, :new, :create, :update]
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @seatgroup = Seatgroup.new
  end
  
  def edit
    @seatgroup = Seatgroup.find(params[:id])
  end
  
  def create
    @seatgroup = Seatgroup.new(seatgroup_params)
    if @seatgroup.save
      redirect_to admin_seatgroups_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @seatgroup = Seatgroup.find(params[:id])
    if @seatgroup.update(seatgroup_params)
      redirect_to admin_seatgroups_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @seatgroup = Seatgroup.find(params[:id])
    if @seatgroup.destroy
      redirect_to admin_seatgroups_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_seatgroups_id] = params[:s_seatgroups_id]
    session[:s_seatgroups_name] = params[:s_seatgroups_name]
    session[:s_seatgroups_ground_id] = params[:s_seatgroups_ground_id]
    session[:s_seatgroups_created_at] = params[:s_seatgroups_created_at]
    session[:s_seatgroups_updated_at] = params[:s_seatgroups_updated_at]
    session[:s_seatgroups_price] = params[:s_seatgroups_price]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_seatgroups_id)
    session.delete(:s_seatgroups_name)
    session.delete(:s_seatgroups_ground_id)
    session.delete(:s_seatgroups_created_at)
    session.delete(:s_seatgroups_updated_at)
    session.delete(:s_seatgroups_price)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def seatgroup_params
      params.require(:seatgroup).permit(:name, :ground_id, :price)
    end
    
    def selected_seatgroups
      params[:order] ||= "id"
      @seatgroups = Seatgroup.selector("id", session[:s_seatgroups_id]).includer("name", session[:s_seatgroups_name]).selector("ground_id", session[:s_seatgroups_ground_id]).created_selector(session[:s_seatgroups_created_at]).updated_selector(session[:s_seatgroups_updated_at]).selector("price", session[:s_seatgroups_price]).order(params[:order])
      @seatgroup_columns = Seatgroup.column_names
    end

end
