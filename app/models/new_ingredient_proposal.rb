class NewIngredientProposal < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :name, presence: true
  validates :status, presence: true
  
  def status_in_japanese
    case status
    when "pending"
      "承認待ち"
    when "approved"
      "承認済み"
    when "rejected"
      "拒否済み"
    else
      "不明"
    end
  end
end