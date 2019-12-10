  require 'rails_helper'

 RSpec.describe ExhibitController, type: :controller do
   
  describe 'GET #index' do
  before do
    get :index
 end 
  it "newアクションが実行されるか" do 
   expect(response).to render_template :index
 end 
   

#    describe 'GET #new' do
#      before do
#        get :new 
#     end 
#      it "newアクションが実行されるか" do 
#       expect(response).to render_template :new
#     end 
#     it "インスタンスが作成されるか" do 
#       expect(assigns(:exhibit)).to be_a_new(Exhibit)
#   end
# end

#   describe 'GET #index' do
#     it "indexアクションが動くか" do
#       get :index
#       expect(response).to render_template :index
#     end
#     end

#     describe 'POST #create' do
#       it "データベースにデータが保存されるか" do
#         expect{
#           post :create, exhibit: attributes_for(:exhibit)
#         }.to change(Exhibit, :count).by(1)
#       end
        
#       end
#   end