class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
    if @card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
    end
  end

  def destroy
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  def new
    redirect_to action: "index" if @card.present?
  end

  def step4
    redirect_to action: "index" if @card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        if get_action ==  "new"
          redirect_to cards_path
        else
          redirect_to complete_signup_index_path
        end
      else
        redirect_to action: "create"
      end
    end
  end

  def pay
    exhibit = Exhibit.find(params[:id])
    if exhibit.user_id != current_user.id && exhibit.buyer_id == nil
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      Payjp::Charge.create(
      :amount => exhibit.price,
      :customer => @card.customer_id,
      :currency => 'jpy',
      )
      exhibit[:buyer_id] = current_user.id
      exhibit.save
      redirect_to action: 'done'
    else
      redirect_to root_path
    end
  end

  def done
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def get_action
    path = Rails.application.routes.recognize_path(request.referer)
    return path[:action]
  end
end
