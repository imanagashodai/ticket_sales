class Admin::SeatsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_seats
  before_action :set_game, only: [:index, :edit, :new, :create, :update]
  before_action :set_seatgroup, only: [:index, :edit, :new, :create, :update]
  before_action :set_user, only: [:index, :edit, :new, :create, :update]
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @seat = Seat.new
  end
  
  def edit
    @seat = Seat.find(params[:id])
  end
  
  def create
    @seat = Seat.new(seat_params)
    if @seat.save
      redirect_to admin_seats_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @seat = Seat.find(params[:id])
    if @seat.update(seat_params)
      redirect_to admin_seats_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @seat = Seat.find(params[:id])
    if @seat.destroy
      redirect_to admin_seats_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_seats_id] = params[:s_seats_id]
    session[:s_seats_seatgroup_id] = params[:s_seats_seatgroup_id]
    session[:s_seats_name] = params[:s_seats_name]
    session[:s_seats_created_at] = params[:s_seats_created_at]
    session[:s_seats_updated_at] = params[:s_seats_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_seats_id)
    session.delete(:s_seats_seatgroup_id)
    session.delete(:s_seats_name)
    session.delete(:s_seats_created_at)
    session.delete(:s_seats_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def seat_params
      params.require(:seat).permit(:seatgroup_id, :name)
    end
    
    def selected_seats
      params[:order] ||= "id"
      @seats = Seat.selector("id", session[:s_seats_id]).selector("seatgroup_id", session[:s_seats_seatgroup_id]).created_selector(session[:s_seats_created_at]).updated_selector(session[:s_seats_updated_at]).includer("name", session[:s_seats_name]).order(params[:order])
      @seat_columns = Seat.column_names
    end

end
