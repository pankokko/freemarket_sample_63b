class Image < ApplicationRecord
  belongs_to :exhibit
  mount_uploader :image, ImageUploader


end
