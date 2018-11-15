class Category < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
