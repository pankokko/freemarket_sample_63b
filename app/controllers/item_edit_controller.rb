class ItemEditController < ApplicationController
  def index
    @exhibit = Exhibit.includes(:images)
  end

  def edit
    @exhibit = Exhibit.find(params[:id])
    #@grandcildren = Category.find(2).children
    #@exhibit.images.new
   end

  def update
    @Exhibit = Exhibit.create(exhibit_params)
    if @Exhibit.save
      redirect_to root_path   
    else 
      render :new
    end
  end
end
