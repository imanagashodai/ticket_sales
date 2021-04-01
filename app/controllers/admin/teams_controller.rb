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
  
  private
    def team_params
      params.require(:team).permit(:name, :ground_id)
    end
    
    def selected_teams
      @id = params[:s_id]
      @name = params[:s_name]
      @created_at = params[:s_created_at]
      @updated_at = params[:s_updated_at]
      @ground_id = params[:s_ground_id]
      params[:order] ||= "id"
      @teams = Team.selector("id", @id).includer("name", @name).includer("created_at", @created_at).includer("updated_at", @updated_at).selector("ground_id", @ground_id).order(params[:order])
      @team_columns = Team.column_names
    end
    
    def set_ground
      @select_ground = {}
      
      Ground.all.each do |ground|
        @select_ground.store("#{ground.id}:#{ground.name}", ground.id)
      end
    end
    
end