class Exhibit < ApplicationRecord

  has_many :images
  has_many :comments
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

  def self.search(search)
    return Exhibit.all unless search
    Exhibit.where(['name LIKE ?', "%#{search}%"])
  end

  def previous
    user.exhibits.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    user.exhibits.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end

end
