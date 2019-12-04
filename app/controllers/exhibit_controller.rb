class ExhibitController < ApplicationController
  def index
    @exhibit = Exhibit.includes(:images)
  end

  def new
    @exhibit = Exhibit.new
    @grandcildren = Category.find(2).children
    @exhibit.images.new
   end

  def create 
    @Exhibit = Exhibit.create(exhibit_params)
    if @Exhibit.save
      redirect_to root_path   
    else 
      render :new
    end
  end

  def edit
  @exhibit = Exhibit.find(params[:id])
  @grandcildren = Category.find(2).children
  
  end

def update
  @exhibit = Exhibit.find(params[:id])
  @exhibit.update(exhibit_params)
  if @exhibit.save
    redirect_to root_path   
  else 
    render :new
  end
end


  def search 
    @exhibit = Exhibit.search(params[:search])
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end
end
