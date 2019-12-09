class Address < ApplicationRecord
  belongs_to :user

  validates :address_phone_number, format: { with: /\A\d{10,11}\z/}
end
