class UsersController < ApplicationController

  before_action :get_card_day, only: [:regi_card]

  def show
    user = User.find(params[:id])
    if user_signed_in? && current_user.id == user.id
      @nickname = user.nickname
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    user = User.find(params[:id])
    if user_signed_in? && current_user.id == user.id
      @nickname = user.nickname
    else
      redirect_to new_user_session_path
    end
  end

  def card
    user = User.find(params[:id])
    if user_signed_in?  && current_user.id == user.id
    else
      redirect_to new_user_session_path
    end
  end

  def regi_card
    user = User.find(params[:id])
    if user_signed_in?  && current_user.id == user.id
    else
      redirect_to new_user_session_path
    end
  end

  def selling
    user = User.find(params[:id])
    item = user.exhibits.all.where(buyer_id: nil)
    @items = item.includes(:images)
    if user_signed_in?  && current_user.id == user.id
    else
      redirect_to new_user_session_path
    end
  end


  def identification
    @user = User.find(params[:id])
    @prefecture = Prefecture.all
    if user_signed_in? && current_user.id == @user.id
    else
      redirect_to new_user_session_path
    end
  end

  def logout
    user = User.find(params[:id])
    if user_signed_in?  && current_user.id == user.id
    else
      redirect_to new_user_session_path
    end
  end

  private

  def get_card_day
    @months = Months.all
    @cardyears = Cardyears.all
  end
end
