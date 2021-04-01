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
  
  private
    def ground_params
      params.require(:ground).permit(:name)
    end
    
    def selected_grounds
      @id = params[:s_id]
      @name = params[:s_name]
      @created_at = params[:s_created_at]
      @updated_at = params[:s_updated_at]
      params[:order] ||= "id"
      @grounds = Ground.selector("id", @id).includer("name", @name).includer("created_at", @created_at).includer("updated_at", @updated_at).order(params[:order])
      @ground_columns = Ground.column_names
    end
    
end
