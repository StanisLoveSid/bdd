class Review < ApplicationRecord
  belongs_to :book, optional: true
end
