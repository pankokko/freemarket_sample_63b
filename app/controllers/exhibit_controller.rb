class ExhibitController < ApplicationController

  before_action :set_exhibit, only:[:edit, :update, :show]

  def index
    @exhibit = Exhibit.includes(:images)
  end

  def new
    @exhibit = Exhibit.new
    @grandcildren = Category.find(2).children
    @exhibits = Image.new
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
    @images = @exhibit.images.all
    @grandcildren = Category.find(2).children
  end 


  def update
    if @exhibit.update(exhibit_params)
      redirect_to root_path
    else 
      render :new
    end
  end

  
  def search 
    @exhibit = Exhibit.search(params[:search])
  end


  def show
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end