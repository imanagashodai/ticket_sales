class ApplicationController < ActionController::Base
  helper_method :current_user, :current_cart, :logged_in?
  
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
  
  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def current_cart
      @current_cart = Cart.where(user_id: session[:user_id])
    end
  
    def logged_in?
      !current_user.nil?
    end
  
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end
    
    def set_ground
      @select_ground = {}
      Ground.all.each do |ground|
        @select_ground.store("#{ground.id}:#{ground.name}", ground.id)
      end
    end
    
    def set_team
      @select_team = {}
      Team.all.each do |team|
        @select_team.store("#{team.id}:#{team.name}", team.id)
      end
    end
    
    def set_game
      @select_game = {}
      Game.all.each do |game|
        @select_game.store("#{game.id}:#{game.hometeam.name}対#{game.visitorteam.name}", game.id)
      end
    end
    
    def set_seatgroup
      @select_seatgroup = {}
      Seatgroup.all.each do |seatgroup|
        @select_seatgroup.store("#{seatgroup.id}:#{seatgroup.name}", seatgroup.id)
      end
    end
    
    def set_user
      @select_user = {}
      User.all.each do |user|
        @select_user.store("#{user.id}:#{user.name}", user.id)
      end
    end
    
    def set_seat
      @select_seat = {}
      Seat.all.each do |seat|
        @select_seat.store("#{seat.id}:#{seat.name}", seat.id)
      end
    end
    
    def set_ticket
      @select_ticket = {}
      Ticket.all.each do |ticket|
        @select_ticket.store(ticket.id, ticket.id)
      end
    end
end
