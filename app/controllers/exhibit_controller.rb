class ExhibitController < ApplicationController

  require "payjp"
  before_action :authenticate_user!
  before_action :set_exhibit, only:[:edit, :update,:show,:exhibiting]
  before_action :set_ransack, only:[:search, :complex_search]

  def index
    @exhibit = Exhibit.where(buyer_id: nil).includes(:images)
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
    if @exhibit.user_id == current_user.id
      @images = @exhibit.images.all
      @grandcildren = Category.find(2).children
    else
      redirect_to root_path
    end
  end


  def update
    if @exhibit.update(exhibit_params)
      redirect_to root_path
    else 
      render :new
    end
  end

  def exhibiting
    @images = @exhibit.images.all
    @grandcildren = Category.find(2).children
  end

  def destroy
    @exhibit = Exhibit.find(params[:id])
    if @exhibit.user_id == current_user.id && @exhibit.destroy
      redirect_to root_path
    else
      redirect_to exhibiting_exhibit_path
    end
  end
  
  def search 
    @exhibit = Exhibit.where(buyer_id: nil).search(params[:search])
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
    @product = Exhibit.find(params[:id])
    if @product.buyer_id == nil
      @category = Category.find(@product.category_id)
      @comment = @product.comments.new
      @comments = @product.comments.includes(:user).order('id DESC')
      @image = @product.images[0].image
      @images = Image.all
      @user = @product.user
      @products = @user.exhibits.limit(6).order('id DESC')
    else
      redirect_to root_path
    end
  end

  def purchase
    @exhibit = Exhibit.find(params[:id])
    @image = Image.where(exhibit_id: @exhibit.id).first
    @address = Address.where(user_id: current_user.id).first
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
    if @card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
    end
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def set_ransack
    @search = Exhibit.where(buyer_id: nil).ransack(params[:q])
    @ship = [["","全て"],["着払い","着払い(購入者負担)"],["送料込み","送料込み(出品者負担)"]]
    @statuses = [["", "すべて"],["新品", "新品・未使用"],["未使用に近い"," 未使用に近い"],["目立った傷や汚れなし","目立った傷や汚れなし"],["やや傷や汚れあり","やや傷や汚れあり"],["傷や汚れあり","傷や汚れあり"],[" 全体的に状態が悪い"," 全体的に状態が悪い"]]
  end

  
  
  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end