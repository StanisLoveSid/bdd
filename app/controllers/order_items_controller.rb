class OrderItemsController < ApplicationController

  def create
    @order_item = OrderItem.new(order_item_params)
    respond_to do |format|
      if @order_item.save
        current_order.order_items << @order_item
        format.html  { redirect_to(books_path, notice: 'Book added to cart') }
      else
        format.html  { redirect_to(books_path, alert: 'Something went wrong') }
      end
    end
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to(cart_path, notice: "Book removed") }
    end
  end

  def index
    @order_items = current_order.order_items
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :book_id)
  end

end
