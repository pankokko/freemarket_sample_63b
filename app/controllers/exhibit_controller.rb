class ExhibitController < ApplicationController

  before_action :exhibit_update, only:[:edit, :update, :show]

  def index
    @exhibit = Exhibit.includes(:images)
  end

  def new
    @exhibit = Exhibit.new
    @grandcildren = Category.find(2).children
    @exhibits.images.new
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
    # @exhibit = Exhibit.find(params[:id])
    @images = @exhibit.images.all
    @grandcildren = Category.find(2).children
  end 


  def update
    # @exhibit = Exhibit.find(params[:id])
    if @exhibit.update(exhibit_params)
       @exhibit.save
      redirect_to root_path
    else 
      render :new
    end
  end

  
  def search 
    @exhibit = Exhibit.search(params[:search])
  end

  def show
    # @exhibit = Exhibit.find(params[:id])
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def exhibit_update
    @exhibit = Exhibit.find(params[:id])
  end
end