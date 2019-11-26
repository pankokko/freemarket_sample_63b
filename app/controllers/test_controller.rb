class TestController < ApplicationController

  
  def index
  end

  def show
    @parents = Category.all
  end
  
  def logout
  end

  def identification
    @prefecture = Prefecture.all
  end


end
