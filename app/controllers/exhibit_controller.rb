class ExhibitController < ApplicationController

  before_action :set_exhibit, only:[:edit, :update, :show]

  def index
    @exhibit = Exhibit.all
  end

  def new
    @exhibit = Exhibit.new
    @grandcildren = Category.find(2).children
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

  private

  def exhibit_params
    params.require(:exhibit).permit(:name,
     :category_id, 
     :buyer_id ,
     :price, 
     :status, 
     :description, 
     :ship, 
     :ship_fee, 
     :prefecture,
     :size, 
     images: []
    ).merge(user_id: current_user.id)
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end



def create
  @exhibit = Exhibit.new(exhibit_params)
  respond_to do |format|
    if @exhibit.save

        params[:product_images][:image].each do |image|
          @exhibit.images.create(image: image, exhibit_id: @exhibit.id)
        end
      format.html{redirect_to root_path}
    else
      @exhibit.images.new
      format.html{render action: 'new'}
    end
  end
end