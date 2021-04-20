class Admin::TeamsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_teams
  before_action :set_ground, only: [:index, :edit, :new, :create, :update]

  layout "admin/admin"
  
  def index
  end
  
  def new
    @team = Team.new
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to admin_teams_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to admin_teams_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      redirect_to admin_teams_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_teams_id] = params[:s_teams_id]
    session[:s_teams_name] = params[:s_teams_name]
    session[:s_teams_created_at] = params[:s_teams_created_at]
    session[:s_teams_updated_at] = params[:s_teams_updated_at]
    session[:s_teams_ground_id] = params[:s_teams_ground_id]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_teams_id)
    session.delete(:s_teams_name)
    session.delete(:s_teams_created_at)
    session.delete(:s_teams_updated_at)
    session.delete(:s_teams_ground_id)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def team_params
      params.require(:team).permit(:name, :ground_id)
    end
    
    def selected_teams
      params[:order] ||= "id"
      @teams = Team.selector("id", session[:s_teams_id]).includer("name", session[:s_teams_name]).created_selector(session[:s_teams_created_at]).updated_selector(session[:s_teams_updated_at]).selector("ground_id", session[:s_teams_ground_id]).order(params[:order])
      @team_columns = Team.column_names
    end
    
end