class PostIngredient < ApplicationRecord
  belongs_to :post
  belongs_to :ingredient

  validates :quantity, presence: true
end