class User < ApplicationRecord
 has_many :orders, dependent: :destroy
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :user_billing, -> { where(addressable_scope: :user_billing) },
    as: :addressable,  class_name: "Address", dependent: :destroy

  has_one :user_shipping, -> { where(addressable_scope: :user_shipping) },
    as: :addressable, class_name: "Address", dependent: :destroy

end
