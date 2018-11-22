module CheckoutPage
  class AddressStepPresenter < Rectify::Presenter
    def initialize(order, billing_form = nil, shipping_form = nil, use_billing = nil)
      @order = order
      @billing_form  = billing_form
      @shipping_form = shipping_form
      @use_billing   = use_billing || order.use_billing
      super()
    end

    attr_reader :use_billing

    def order_billing
      @order_billing = address(:order_billing)
    end

    def order_shipping
      @order_shipping = address(:order_shipping)
    end

    def shipping_fields_style
      'display: none;' if use_billing
    end

    private

    def address(type)
      address = instance_variable_get("@#{type}_form") ||
                current_order.send("#{type}")  ||
                current_user.send("#{type}")

      return address if address


    end
  end
end
