class ProductController < ApplicationController
  def index
  end
  def show
    # id =  Product.find(params[:id])
    # @product = id.includes(:images)
    
    @product = Exhibit.find(params[:id])
    @image = Image.includes(:exhibit).find(@product.id)
    @products = Exhibit.where(user_id: current_user.id)
    @images = Image.all
    @user = User.find(@product.user_id)
    @products = Exhibit.joins(:images).where(user_id: @product.user_id).limit(6).order('id DESC')
  end 
end
