class ExhibitController < ApplicationController
  before_action :set_exhibit, only:[:edit, :update, :show]
  before_action :set_ransack, only:[:search, :complex_search]

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
    #headerからの検索
    @exhibit = Exhibit.search(params[:search])
    #headerから検索した文字を画面に表示
    @result = params[:search]
    #ransackを使った検索
    #@search = Exhibit.ransack(params[:q])
  end

  def complex_search
  #@search = Exhibit.ransack(params[:q])
  @status = Exhibit.all
  @exhibit = @search.result.includes(:category)
  end


  def show
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def set_ransack
    @search = Exhibit.ransack(params[:q])

  end


  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end