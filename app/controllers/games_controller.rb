class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end
  
  def create
    cart = Cart.new(ticket_id: params[:ticket_id], user_id: current_user.id)
    if cart.save
      redirect_to game_path(id: params[:game_id]), success: "カートに入れました"
    else
      flash.now[:danger] = "失敗"
      render :show
    end
  end
  
end
