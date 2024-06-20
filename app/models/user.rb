class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  
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