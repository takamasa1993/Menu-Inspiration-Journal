# app/models/user.rb
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :new_ingredient_proposals, dependent: :destroy

  # フォロー機能
  has_many :active_relationships, class_name: 'UserFollow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'UserFollow', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # フォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # フォローを外す
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # すでにフォローしているか確認
  def following?(other_user)
    following.include?(other_user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = "ゲストユーザー"
      user.nickname = "ゲスト"
    end
  end


  # Devise の設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :name, presence: true
  validates :nickname, presence: true

  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation) if params[:password].blank?

    result = update(params, *options)
    clean_up_passwords
    result
  end
end