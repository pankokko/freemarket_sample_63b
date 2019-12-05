class ProductController < ApplicationController
  def index
  end
  def show
    @product = Exhibit.find(params[:id])
    @image = Image.find(params[:id])
    @images = Image.all
    @user = User.find(@product.user_id)
    @products = Exhibit.where(user_id: @product.user_id).limit(6).order('id DESC')
    binding.pry
  end
end