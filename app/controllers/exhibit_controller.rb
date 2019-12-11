class ExhibitController < ApplicationController

  require "payjp"
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_exhibit, only:[:edit, :update, :show, :destroy]
  before_action :set_ransack, only:[:search, :complex_search]

  def index
    @exhibit = Exhibit.where(buyer_id: nil).includes(:images)
  end

  def new
    @exhibit = Exhibit.new
    @grandchildren = Category.find(3).children
    @exhibits = Image.new
   end

  def create 
    if exhibit_params[:images_attributes] != nil
      @Exhibit = Exhibit.create(exhibit_params)
      if @Exhibit.save
        redirect_to root_path   
      else 
        render :new
      end
    else
      redirect_to new_exhibit_path
    end
  end

  def edit 
    if @exhibit.user_id == current_user.id
      @images = @exhibit.images.all
      @grandchildren = Category.find(3).children
    else
      redirect_to root_path
    end
  end

  def update
    if @exhibit.user_id == current_user.id
      if exhibit_params[:images_attributes] != nil
        if @exhibit.update(exhibit_params)
          redirect_to root_path
        else 
          redirect_to edit_exhibit_path(@exhibit.id)
        end
      else
        flash[:notice] = "画像を投稿して下さい"
        redirect_to edit_exhibit_path(@exhibit.id)
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if @exhibit.user_id == current_user.id
      if @exhibit.user_id == current_user.id && @exhibit.destroy
        redirect_to root_path
      else
        redirect_to exhibiting_exhibit_path
      end
    else
      redirect_to root_path
    end
  end
  
  def search 
    @exhibit = Exhibit.where(buyer_id: nil).search(params[:search])
    @result = params[:search]

  end

  def complex_search
  @exhibit = @search.result.includes(:category)
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
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
    if @exhibit.user_id != current_user.id && @exhibit.buyer_id == nil
      if @card != nil
        @image = Image.where(exhibit_id: @exhibit.id).first
        @address = Address.where(user_id: current_user.id).first
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @card_information = customer.cards.retrieve(@card.card_id)
        @card_brand = @card_information.brand
      elsif user_signed_in?  
        redirect_to root_path
      else 
        redirect_to cards_path
      end
    else
      redirect_to root_path
    end
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:exhibit_id,:image,:id]).merge(user_id: current_user.id)
  end

  def set_ransack
    @search = Exhibit.where(buyer_id: nil).ransack(params[:q])
    @ship = [["","全て"],["着払い","着払い(購入者負担)"],["送料込み","送料込み(出品者負担)"]]
    @statuses = [["", "すべて"],["新品", "新品・未使用"],["未使用に近い"," 未使用に近い"],["目立った傷や汚れ無し","目立った傷や汚れ無し"],["やや傷や汚れあり","やや傷や汚れあり"],["傷や汚れあり","傷や汚れあり"],["全体的に状態が悪い","全体的に状態が悪い"]]
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end
end