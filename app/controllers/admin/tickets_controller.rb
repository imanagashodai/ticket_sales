class Admin::TicketsController < ApplicationController
  before_action :if_not_admin
  before_action :selected_tickets
  before_action :set_game, only: [:index, :edit, :new, :create, :update]
  before_action :set_seat, only: [:index, :edit, :new, :create, :update]
  
  layout "admin/admin"
  
  def index
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to admin_tickets_path, success: "登録完了"
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to admin_tickets_path, success: "更新完了"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    if @ticket.destroy
      redirect_to admin_tickets_path, info: "削除完了"
    else
      flash.now[:danger] = "削除失敗"
      render :edit
    end
  end
  
  def search
    session[:s_tickets_id] = params[:s_tickets_id]
    session[:s_tickets_game_id] = params[:s_tickets_game_id]
    session[:s_tickets_seat_id] = params[:s_tickets_seat_id]
    session[:s_tickets_created_at] = params[:s_tickets_created_at]
    session[:s_tickets_updated_at] = params[:s_tickets_updated_at]
    redirect_back(fallback_location: root_path)
  end
  
  def reset
    session.delete(:s_tickets_id)
    session.delete(:s_tickets_game_id)
    session.delete(:s_tickets_seat_id)
    session.delete(:s_tickets_created_at)
    session.delete(:s_tickets_updated_at)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def ticket_params
      params.require(:ticket).permit(:game_id, :seat_id)
    end
    
    def selected_tickets
      params[:order] ||= "id"
      @tickets = Ticket.selector("id", session[:s_tickets_id]).selector("game_id", session[:s_tickets_game_id]).selector("seat_id", session[:s_tickets_seat_id]).created_selector(session[:s_tickets_created_at]).updated_selector(session[:s_tickets_updated_at]).order(params[:order])
      @ticket_columns = Ticket.column_names
    end

end
