# app/models/new_ingredient_proposal.rb
class NewIngredientProposal < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
end