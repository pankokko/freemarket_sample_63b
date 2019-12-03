class Exhibit < ApplicationRecord

has_many :images
belongs_to :category
belongs_to :user

accepts_nested_attributes_for :images

validates :name, presence: true 
validates :ship, presence: true 
validates :ship_fee, presence: true 
validates :prefecture, presence: true 
validates :description, presence: true
validates :status, presence: true
validates :price, presence:  true

end
