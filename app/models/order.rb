class Order < ApplicationRecord
  include AASM
  
  has_many :order_items
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_one :credit_card, dependent: :destroy
  has_one :coupon, dependent: :nullify

  has_one :order_billing, -> { where(addressable_scope: :order_billing) },
    as: :addressable,  class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :order_billing, allow_destroy: true

  has_one :order_shipping, -> { where(addressable_scope: :order_shipping) },
    as: :addressable, class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :order_shipping, allow_destroy: true

  aasm do
    state :in_progress, initial: true
    state :processing
    state :in_delivery
    state :delivered
    state :cancelled

    event :place_order do
      transitions from: :in_progress, to: :processing
    end

    event :sent_to_client do
      transitions from: :processing, to: :in_delivery
    end

    event :end_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: [:processing, :in_delivery], to: :cancelled
    end
  end

end
