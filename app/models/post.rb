class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :image

  has_many :post_ingredients, dependent: :destroy
  has_many :ingredients, through: :post_ingredients

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

  accepts_nested_attributes_for :post_ingredients, allow_destroy: true
end