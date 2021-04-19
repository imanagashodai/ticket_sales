class Admin::CartsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_carts
  before_action :set_user, only: [:index, :edit, :new, :create, :update]
  before_action :set_ticket, only: [:index, :edit, :new, :create, :update]
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @cart = Cart.new
  end
  
  def edit
    @cart = Cart.find(params[:id])
  end
  
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to admin_carts_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to admin_carts_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    if @cart.destroy
      redirect_to admin_carts_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_carts_id] = params[:s_carts_id]
    session[:s_carts_ticket_id] = params[:s_carts_ticket_id]
    session[:s_carts_user_id] = params[:s_carts_user_id]
    session[:s_carts_created_at] = params[:s_carts_created_at]
    session[:s_carts_updated_at] = params[:s_carts_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_carts_id)
    session.delete(:s_carts_ticket_id)
    session.delete(:s_carts_user_id)
    session.delete(:s_carts_created_at)
    session.delete(:s_carts_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def cart_params
      params.require(:cart).permit(:ticket_id, :user_id)
    end
    
    def selected_carts
      @id = params[:s_id]
      @ticket_id = params[:s_ticket_id]
      @user_id = params[:s_user_id]
      @created_at = params[:s_created_at]
      @updated_at = params[:s_updated_at]
      params[:order] ||= "id"
      @carts = Cart.selector("id", session[:s_carts_id]).selector("user_id", session[:s_carts_user_id]).selector("ticket_id", session[:s_carts_ticket_id]).includer("created_at", session[:s_carts_created_at]).includer("updated_at", session[:s_carts_updated_at]).order(params[:order])
      @cart_columns = Cart.column_names
    end
    
end
