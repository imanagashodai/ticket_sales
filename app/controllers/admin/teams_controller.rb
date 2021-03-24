class Admin::TeamsController < ApplicationController
  before_action :if_not_admin
  before_action :all_team
  before_action :set_team, only: [:show, :edit, :destroy, :update]
  before_action :set_ground, only: [:edit, :new, :create, :update]

  layout "admin"
  
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to admin_teams_path, success: "チーム登録しました"
    else
      flash.now[:danger] = "チーム登録失敗"
      render :new
    end
  end
  
  def update
    if @team.update(team_params)
      redirect_to admin_teams_path, success: "チームデータ更新しました"
    else
      flash.now[:danger] = "チームデータ更新失敗"
      render :edit
    end
  end

  def destroy
    if @team.destroy
      redirect_to admin_teams_path, info: "チーム削除しました"
    else
      flash.now[:danger] = "チーム削除失敗"
      render :edit
    end
  end
  
  private
    def team_params
      params.require(:team).permit(:name, :ground_id)
    end
  
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end
    
    def all_team
      @id = params[:s_id]
      @ground_id = params[:s_ground_id]
      @teams = Team.selector("id", @id).selector("ground_id", @ground_id).order(params[:order])
      @team_columns = Team.column_names
      # @team_columns = ["id", "name", "ground_id"]
    end
  
    def set_team
      @team = Team.find(params[:id])
    end
    
    def set_ground
      @select_ground = {}
      
      Ground.all.each do |ground|
        @select_ground.store("#{ground.id}:#{ground.name}", ground.id)
      end
    end
    
end
