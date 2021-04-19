module ApplicationHelper
  def order_machine(column)
    if params[:order] == column
      link_to column, params.merge(order: "#{column} desc").permit!
    else
      link_to column, params.merge(order: column).permit!
    end
  end
end
