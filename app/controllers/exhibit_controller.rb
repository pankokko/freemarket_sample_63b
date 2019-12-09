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
    @exhibit = Exhibit.search(params[:search])
    @result = params[:search]
    # @ship = [["","全て"],["着払い","着払い(購入者負担)"],["送料込み","送料込み(出品者負担)"]]
    # @statuses = [["", "すべて"],["新品", "新品・未使用"],["未使用に近い"," 未使用に近い"],["目立った傷や汚れなし","目立った傷や汚れなし"],["やや傷や汚れあり","やや傷や汚れあり"],["傷や汚れあり","傷や汚れあり"],[" 全体的に状態が悪い"," 全体的に状態が悪い"]]
  end

  def complex_search
  @exhibit = @search.result.includes(:category)
  # @statuses = [["", "すべて"],["新品", "新品・未使用"],["未使用に近い"," 未使用に近い"],["目立った傷や汚れなし","目立った傷や汚れなし"],["やや傷や汚れあり","やや傷や汚れあり"],["傷や汚れあり","傷や汚れあり"],[" 全体的に状態が悪い"," 全体的に状態が悪い"]]
  # @ship = [["","全て"],["着払い","着払い(購入者負担)"],["送料込み","送料込み(出品者負担)"]]
  end


  def show
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def set_ransack
    @search = Exhibit.ransack(params[:q])
    @ship = [["","全て"],["着払い","着払い(購入者負担)"],["送料込み","送料込み(出品者負担)"]]
    @statuses = [["", "すべて"],["新品", "新品・未使用"],["未使用に近い"," 未使用に近い"],["目立った傷や汚れなし","目立った傷や汚れなし"],["やや傷や汚れあり","やや傷や汚れあり"],["傷や汚れあり","傷や汚れあり"],[" 全体的に状態が悪い"," 全体的に状態が悪い"]]
  end


  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end