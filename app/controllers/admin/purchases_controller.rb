class Admin::PurchasesController < ApplicationController
  before_action :if_not_admin
  before_action :selected_purchases
  before_action :set_ticket, only: [:index, :edit, :new, :create, :update]
  before_action :set_user, only: [:index, :edit, :new, :create, :update]
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @purchase = Purchase.new
  end
  
  def edit
    @purchase = Purchase.find(params[:id])
  end
  
  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to admin_purchases_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @purchase = Purchase.find(params[:id])
    if @purchase.update(purchase_params)
      redirect_to admin_purchases_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    if @purchase.destroy
      redirect_to admin_purchases_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_purchases_id] = params[:s_purchases_id]
    session[:s_purchases_ticket_id] = params[:s_purchases_ticket_id]
    session[:s_purchases_user_id] = params[:s_purchases_user_id]
    session[:s_purchases_created_at] = params[:s_purchases_created_at]
    session[:s_purchases_updated_at] = params[:s_purchases_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_purchases_id)
    session.delete(:s_purchases_ticket_id)
    session.delete(:s_purchases_user_id)
    session.delete(:s_purchases_created_at)
    session.delete(:s_purchases_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def purchase_params
      params.require(:purchase).permit(:name, :ticket_id, :user_id)
    end
    
    def selected_purchases
      params[:order] ||= "id"
      @purchases = Purchase.selector("id", session[:s_purchases_id]).includer("name", session[:s_purchases_ticket_id]).selector("ground_id", session[:s_purchases_user_id]).includer("created_at", session[:s_purchases_created_at]).includer("updated_at", session[:s_purchases_updated_at]).order(params[:order])
      @purchase_columns = Purchase.column_names
    end

end
