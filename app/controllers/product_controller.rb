class ProductController < ApplicationController

  def show
    @product = Exhibit.find(params[:id])
    # @comment = @product.comments.new
    # @comments = @comment.current_user.id.new

    @commentd = Comment.new
    


    
    @image = @product.images[0].image
    @images = Image.all
    @user = @product.user

    @products = @user.exhibits.limit(6).order('id DESC')
  end
  

end