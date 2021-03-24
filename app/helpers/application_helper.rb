module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def order_machine(column)
    if params[:order] == column
      link_to column, order: "#{column} desc"
    else
      link_to column, order: column
    end
  end
end
