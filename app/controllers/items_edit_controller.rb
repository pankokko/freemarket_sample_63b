class ItemsEditController < ApplicationController
  def edit
    @post = Item.find(params[:id])
  end

  def update
  end
  def show
    @post = Item.find(params[:id])
    @name = User.find(params[:id])
  end
end




