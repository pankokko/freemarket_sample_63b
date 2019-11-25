class SignupController < ApplicationController
  def index
  end
  
  def login
  end

  def registration
  end

  def sms_confirmation
  end

  def address
    @prefecture = Prefecture.all
  end

  def card
  end

  def complete
  end
end
