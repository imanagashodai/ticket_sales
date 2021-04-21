class TeamsController < ApplicationController
  def index
  end
  
  def show
    @games = Game.where(hometeam_id: params[:id]).or(Game.where(visitorteam_id: params[:id])).order(:datetime)
  end
end
