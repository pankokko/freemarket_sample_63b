class ExhibitController < ApplicationController
  def index
    @exhibit = Exhibit.all.includes(:images)
    #@image = @exhibit.Images.all
    end

def new
  @exhibit = Exhibit.new
  @exhibit.images.new
 end


def create 
   @Exhibit = Exhibit.create(exhibit_params)
   if @Exhibit.save
    redirect_to root_path    
end 
end 


def exhibit_params
params.require(:exhibit).permit(:name, :price, :status, :description, :ship, :ship_fee, :prefecture,:size,  images_attributes: [:image])

end
end