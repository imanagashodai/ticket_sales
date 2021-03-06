class TeamsController < ApplicationController
  def index
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update(name: params[:team][:name])
      redirect_to root_path
    else
      render :edit
    end
  end
end
