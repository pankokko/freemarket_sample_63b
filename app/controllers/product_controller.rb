class ProductController < ApplicationController
  def index
  end
  def show
    @product = Exhibit.find(params[:id])
    @image = @product.images[0].image
    @images = Image.all
    @user = @product.user
    @products = @user.exhibits.limit(6).order('id DESC')
  end
end