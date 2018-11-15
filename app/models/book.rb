class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  belongs_to :category, optional: true
  has_many :order_items
  has_many :reviews
  validates :title, presence: true
  #validates :description, length: { maximum: 500 }

  #validates :price,
  #  presence: true,
  #numericality: {
  #  greater_than_or_equal_to: 0.00
  #}
end
