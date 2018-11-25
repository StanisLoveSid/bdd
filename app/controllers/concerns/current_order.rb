module CurrentOrder
  extend ActiveSupport::Concern

  included do
    helper_method :current_order
  end

  def current_order
    if session[:order_id].nil?
      create_current_order
    else
      create_order_if_processing
    end
  end

  def create_order_if_processing
    find_order.processing? ? create_current_order : find_order
  end

  def find_order
    Order.find(session[:order_id])
  end

  def create_current_order
    order = Order.create
    session[:order_id] = order.id
    order
  end

end
