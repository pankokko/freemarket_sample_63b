class ExhibitController < ApplicationController
  def index
    @exhibit = Exhibit.all.includes(:images)
    end

def new
  @exhibit = Exhibit.new
  @grandcildren = Category.find(2).children
  @exhibit.images.new
 end


def create 
   @Exhibit = Exhibit.create(exhibit_params)
   if @Exhibit.save
    redirect_to root_path    
end 
end 


def exhibit_params
params.require(:exhibit).permit(:name, :category_id, :buyer_id ,:price, :status, :description, :ship, :ship_fee, :prefecture,:size, images_attributes: [:image]).merge(user_id: current_user.id)
end
end


# exhibitのレコードを作成する
# 同時にアソシエーションを組んでいるカテゴリーのレコードも作成する。
# 同じく画像も・・・。



# url=>/sample/:id/edit

# :id
# params[:id]

# {name: "aaaa", name2:{text:"bbb"}}

# name2[:text]=>bbb

# params[:name] => aaaa

# params[:text] => bbb  NO!!

# params.require(:exhibit).permit(:name, text: params[:name2], :id)  No!!
# params.require(:exhibit).permit(:name).merge(params[:id])




