class Form::Registration
  include ActiveModel::Model

  attr_accessor :category,
                :exhibit,
                :image

  validate :validate_category
  validate :validate_exhibit
  validate :validate_image

  def initialize(params: {})
    @image = Image.new(params[:image_params])
    @exhibit = Exhibit.new(params[:Exhibit_params])
    @category = Category.new(params[:category_params])
  end

  def save
    @image.save
    @exhibit.save
    @category.save
  end
  .
  .
  .

end
