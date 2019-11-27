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

end
