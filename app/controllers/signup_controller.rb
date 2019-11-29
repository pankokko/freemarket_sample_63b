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
end