class Admin::TeamsController < ApplicationController
  before_action :if_not_admin
  before_action :set_team, only: [:show, :edit, :destroy]

  
  layout "admin"
  
  def update
    @team = Team.find(params[:id])
    if @team.update(name: params[:team][:name])
      redirect_to admin_teams_path
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      redirect_to admin_teams_path
    else
      render :edit
    end
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
  
  def set_team
    @team = Team.find(params[:id])
  end
end
