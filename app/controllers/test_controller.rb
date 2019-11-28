class TestController < ApplicationController

  def index
  end

  def show
  end
  
  def logout
  end

  def identification
    @prefecture = Prefecture.all
  end

  def card
  end

  def regi_card
    @months = Months.all
    @cardyears = Cardyears.all
  end
end
