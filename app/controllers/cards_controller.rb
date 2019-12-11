class CardsController < ApplicationController
  require "payjp"
  before_action :set_card
  before_action :authenticate_user!

  def index #CardのデータをPayjpに送って情報を取り出す
    if @card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
    end
  end

  def destroy #PayjpとCardのデータベースを削除
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy #削除に成功した時にポップアップを表示します。
      redirect_to action: "index", notice: "削除しました"
    else #削除に失敗した時にアラートを表示します。
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    redirect_to action: "index" if @card.present?
  end

  def step4
    redirect_to action: "index" if @card.present?
  end

  def create #PayjpとCardのデータベースを作成
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer = Payjp::Customer.create(
        description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
        email: current_user.email,
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
        metadata: {user_id: current_user.id} # 無くてもOK。
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
      :amount => exhibit.price, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => @card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
      )
      exhibit[:buyer_id] = current_user.id
      exhibit.save
      redirect_to action: 'done' #完了画面に移動
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
