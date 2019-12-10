class SignupController < ApplicationController
 before_action :authenticate_user!, except: [:step1, :step2, :create]
  def index
  end

  def complete
  end

  def step1
    @user = User.new
  end

  def step2
    if verifyRecaptchaToken
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
      @user = User.new
    else
      redirect_to step1_signup_index_path
    end
  end

  def create
    session[:phone_number] = user_params[:phone_number]
    @user = User.create(
      nickname: session[:nickname],
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
    if @user.save
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      redirect_to step3_address_index_path
    else
      render step2_signup_index_path
    end
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

  def verifyRecaptchaToken
    @model = User.new
    verify_recaptcha(model: @model)
    if @model.errors.empty?
       return true
    else
       return false
    end
  end

end