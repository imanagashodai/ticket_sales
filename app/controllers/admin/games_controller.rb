class Admin::GamesController < ApplicationController
  before_action :if_not_admin
  before_action :selected_games
  before_action :set_ground, only: [:index, :edit, :new, :create, :update]
  before_action :set_team, only: [:index, :edit, :new, :create, :update]

  layout "admin/admin"
  
  def index
  end
  
  def new
    @game = Game.new
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to admin_games_path, success: "登録完了"
    else
      # flash.now[:danger] = "登録失敗"
      flash.now[:danger] = @game.errors.full_messages
      render :new
    end
  end
  
  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to admin_games_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      redirect_to admin_games_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_games_id] = params[:s_games_id]
    session[:s_games_datetime] = params[:s_games_datetime]
    session[:s_games_hometeam_id] = params[:s_games_hometeam_id]
    session[:s_games_visitorteam_id] = params[:s_games_visitorteam_id]
    session[:s_games_ground_id] = params[:s_games_ground_id]
    session[:s_games_created_at] = params[:s_games_created_at]
    session[:s_games_updated_at] = params[:s_games_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_games_id)
    session.delete(:s_games_datetime)
    session.delete(:s_games_hometeam_id)
    session.delete(:s_games_visitorteam_id)
    session.delete(:s_games_ground_id)
    session.delete(:s_games_created_at)
    session.delete(:s_games_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def game_params
      params.require(:game).permit(:datetime, :hometeam_id, :visitorteam_id, :ground_id)
    end
    
    def selected_games
      params[:order] ||= "id"
      @games = Game.selector("id",  session[:s_games_id]).datetime_selector(session[:s_games_datetime]).selector("hometeam_id",  session[:s_games_hometeam_id]).selector("visitorteam_id",  session[:s_games_visitorteam_id]).selector("ground_id",  session[:s_games_ground_id]).created_selector(session[:s_games_created_at]).updated_selector(session[:s_games_updated_at]).order(params[:order])
      @game_columns = Game.column_names
    end
    
end