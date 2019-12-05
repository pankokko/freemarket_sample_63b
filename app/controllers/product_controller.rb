class ProductController < ApplicationController
  def index
  end
  def show
    @product = Exhibit.find(params[:id])
    @image = Image.find(params[:id])
    @images = Image.all
    @user = @product.user
    @products = Exhibit.where(user_id: @product.user).limit(6).order('id DESC')
    
  end
end