module ApplicationHelper

  def current_order
    if session[:order_id].present?
      begin
        Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound
        # If the order with the stored ID doesn't exist, reset the session
        session[:order_id] = nil
        Order.new
      end
    else
      Order.new
    end
  end
  
end
