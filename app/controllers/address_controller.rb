class AddressController < ApplicationController
  before_action :authenticate_user!
  def step3
    @address = Address.new
  end

  def create
    @address = Address.create(address_params)
    if @address.save
      redirect_to step4_cards_path
    else 
      render :step3
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :address_family_name_kanji,
      :address_family_name_kana,
      :address_first_name_kanji,
      :address_first_name_kana,
      :address_number,
      :address_prefecture,
      :address_name,
      :address_block,
      :address_building,
      :address_phone_number
    ).merge(user_id: current_user.id)
  end

end
