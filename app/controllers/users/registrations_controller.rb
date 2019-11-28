# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
    before_action :get_days, only: [:new,:create]
  # GET /resource/sign_up

  def get_days
    @days = Days.all
    @months = Months.all
    @years = Years.all
  end


   def new
     super
   end
 
   def create
    if verify_recaptcha(model: @User)
      @User = User.create!(user_params)
      @User.save
      redirect_to "/signup/sms_confirmation" ,  notice: 'ログインとデータの保存に成功しました。'
    else 
      super
   end
  end

  # GET /resource/edit
   def edit
     super
   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
   def destroy
     super
   end

  

def user_params
  params.permit(:nickname, :email, :password, :family_name_kana, :family_name_kanji, :first_name_kana, :first_name_kanji, :year, :month, :day)
end



 def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [:password, :email, :nickname, :family_name_kana, :family_name_kanji, :first_name_kana, :first_name_kanji, :year, :month, :day])
 end
end
