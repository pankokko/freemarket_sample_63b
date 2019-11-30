class ExhibitController < ApplicationController
  def index
    @exhibit = Exhibit.all
    end

def new 
  @exhibit = Exhibit.new
 end


def create 
  Exhibit.create(exhibit_params)
end 


def exhibit_params
params.require(:exhibit).permit(:name)

end

end