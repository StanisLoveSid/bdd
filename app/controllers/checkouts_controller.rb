class CheckoutsController < ApplicationController
  include Rectify::ControllerHelpers
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    @order = current_order
    render_wizard
  end

  #def update
  #  @order = current_order
  #  case step
  #  when :address
  #    @order.build_order_billing(order_billing_params)
  #    if params[:use_billing] == "1"
  #      @order.build_order_shipping(order_billing_params)
  #    else
  #      @order.build_order_shipping(order_shipping_params)
  #    end
  #    @order.save
  # when :delivery
  #    delivery = Delivery.find_by(id: [params[:order][:delivery_id]])
  #    @order.delivery = delivery
  #    @order.save
  #  when :credit_card
  #    @order.build_credit_card(credit_card_params)
  #    @order.save
  #  when :confirm
  #   @order.place_order
  #  when :complete
  #  end
  #  render_wizard @order
  #end

  def update
    CheckoutPage::ProceedCheckout.call(current_order, params, step) do
      on(:invalid) do |*attrs|
        present step_presenter.new(*attrs)
        render_wizard
      end
      on(:ok) { render_wizard current_order }
    end
  end

  def step_presenter
    "CheckoutPage::#{step.capitalize}StepPresenter".constantize
  end


  private

  def credit_card_params
    params.require(:order).require(:credit_card).permit(:name, :number, :expiration_date, :cvv)
  end

  def order_billing_params
    params[:order_billing][:address].permit(:zipcode, :country, :city, :phone, :address, :addressable_type, :addressable_id, :created_at, :updated_at)
  end

  def order_shipping_params
    params[:order_shipping][:address].permit(:zipcode, :country, :city, :phone, :address, :addressable_type, :addressable_id, :created_at, :updated_at)
  end

end
