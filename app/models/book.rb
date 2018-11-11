class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  belongs_to :category, optional: true
  has_many :order_items
  has_many :reviews
end
