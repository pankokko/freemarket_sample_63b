class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
          
  has_many :payments
  has_many :comments
  has_many :likes
  has_many :items
  has_many :users, through: :users_historys
  has_many :users_historys
  has_one :address

  validates :nickname, presence: true, length: { maximum: 6 }
  validates :email, uniqueness: true  
  validates :year, presence: true
  validates :month, presence: true 
  validates :day, presence: true 

  validates :first_name_kanji, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :family_name_kanji, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
end
