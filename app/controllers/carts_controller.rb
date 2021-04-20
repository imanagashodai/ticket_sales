class CartsController < ApplicationController
  def create
    @ticket_ids = Cart.where(user_id: session[:user_id]).pluck(:ticket_id)
    @ticket_ids.each do |ticket_id|
      @purchase = Purchase.new(ticket_id: ticket_id, user_id: session[:user_id])
      unless @purchase.save
        Purchase.where(ticket_id: @ticket_ids, user_id: session[:user_id]).delete_all
        return redirect_to cart_path(session[:user_id]), danger: "#{ticket_id}は既に売り切れです"
      end
    end
    Cart.where(user_id: session[:user_id]).delete_all
    redirect_to cart_path(session[:user_id]), success: "購入"
  end
  
  def destroy
    if Cart.where(user_id: params[:id]).delete_all
      redirect_to cart_path, success: "成功"
    else
      flash.now[:danger] = "失敗"
      render :show
    end
  end
end