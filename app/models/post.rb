class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :menu_title, presence: true
  validates :genre, presence: true
  validates :energy, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fat, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :calcium, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :iron, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :zinc, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :vitamin_a, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :vitamin_b1, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :vitamin_b2, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :vitamin_c, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :dietary_fiber, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :salt, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 500 }
end