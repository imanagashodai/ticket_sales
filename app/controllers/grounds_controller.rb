class GroundsController < ApplicationController
  def show
    @games = Game.where(ground_id: params[:id]).order(:datetime)
  end
end
