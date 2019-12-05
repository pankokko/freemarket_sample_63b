class SignupController < ApplicationController
  def index
  end

  def login
  end

  def registration
    @days = Days.all
    @months = Months.all
    @years = Years.all
  end

  def sms_confirmation
  end

  def address
    @prefecture = Prefecture.all
  end

  def card
    @months = Months.all
    @cardyears = Cardyears.all
  end

  def complete
  end

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name_kanji] = user_params[:family_name_kanji]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kanji] = user_params[:first_name_kanji]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:year] = user_params[:year]
    session[:month] = user_params[:month]
    session[:day] = user_params[:day]
    @user = User.new # 新規インスタンス作成
  end

  def step3
    session[:phone_number] = user_params[:phone_number]
    @user = User.new # 新規インスタンス作成
  end

  # def step4
  #   session[:address_family_name_kanji] = user_params[:address_family_name_kanji]
  #   session[:address_family_name_kana] = user_params[:address_family_name_kana]
  #   session[:address_first_name_kanji] = user_params[:address_first_name_kanji]
  #   session[:address_first_name_kana] = user_params[:address_first_name_kana]
  #   session[:address_number] = user_params[:address_number]
  #   session[:address_prefecture] = user_params[:address_prefecture]
  #   session[:address_name] = user_params[:address_name]
  #   session[:address_block] = user_params[:address_block]
  #   session[:address_building] = user_params[:address_building]
  #   session[:address_phone_number] = user_params[:address_phone_number]
  #   @user = User.new
  # end

  def create
    session[:phone_number] = user_params[:phone_number]
    @user = User.create(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name_kanji: session[:family_name_kanji], 
      family_name_kana: session[:family_name_kana], 
      first_name_kanji: session[:first_name_kanji], 
      first_name_kana: session[:first_name_kana], 
      year: session[:year],
      month: session[:month],
      day: session[:day],
      phone_number: session[:phone_number],
    )
    if true
      # ログインするための情報を保管
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      redirect_to step3_address_index_path
    else
      render '/signup/registration'
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :password_confirmation, 
      :family_name_kanji, 
      :family_name_kana,
      :first_name_kanji, 
      :first_name_kana,
      :year,
      :month,
      :day,
      :phone_number,
      :encrypted_password,
  )
  end

end