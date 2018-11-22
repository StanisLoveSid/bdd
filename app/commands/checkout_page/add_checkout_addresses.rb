module CheckoutPage
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @use_billing = use_billing?

      set_address(:billing)
      set_address(:shipping) unless @use_billing
      unless [@order_billing, @order_shipping].compact.all?(&:valid?)
        broadcast(:invalid, @order, @order_billing, @order_shipping, @use_billing)
        return
      end

      create_address(:order_billing)
      create_address(:order_shipping) unless @use_billing
      save_use_billing

      broadcast(:ok, @order)
    end

    private

    def set_address(type)
      form = AddressForm.new params_for_address(type)
      instance_variable_set("@order_#{type}", form)
    end

    def create_address(type)
      attrs = instance_variable_get("@#{type}").attributes
      @order.send("#{type}")&.delete
      @order.send("build_#{type}", attrs)
      @order.save
    end

    def save_use_billing
      return if @use_billing == @order.use_billing
      @order.update(use_billing: true)
    end

    def use_billing?
      @params[:order][:use_billing] == '1'
    end

    def params_for_address(type)
      @params.require(:order).require(type).permit(
        :first_name,
        :last_name,
        :address,
        :city,
        :zipcode,
        :country,
        :addressable_type,
        :addressable_id,
        :phone
      ).to_h
    end
  end
end
