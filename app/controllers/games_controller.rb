class GamesController < ApplicationController
  before_action :game_set_tickets
  
  def show
    @game = Game.find(params[:id])
  end
  
  def create
    cart = Cart.new(ticket_id: params[:ticket_id], user_id: current_user.id)
    if cart.save
      redirect_to game_path(id: params[:game_id]), success: "カートに入れました"
    else
      @game = Game.find(params[:game_id])
      flash.now[:danger] = "売り切れです"
      render :show
    end
  end
  
  private
    def game_set_tickets
      @sold_ticket_ids = Purchase.pluck(:ticket_id)
      @cart_ticket_ids = Cart.where(user_id: session[:user_id]).pluck(:ticket_id)
    end
  
end
