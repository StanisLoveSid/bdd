class ApplicationController < ActionController::Base
  helper_method :current_order
  protect_from_forgery with: :exception

  def current_order
    if session[:order_id].nil?
      order = Order.create
      session[:order_id] = order.id
      order
    else
      Order.find(session[:order_id])
    end
  end

end
