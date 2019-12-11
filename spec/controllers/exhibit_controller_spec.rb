  require 'rails_helper'

 RSpec.describe ExhibitController, type: :controller do
  exhibit = Exhibit.find(1)
  user = User.find(1)
  exhibit_dummy = FactoryBot.create(:exhibit)
  
  describe 'GET #new' do
    before do
      login_user user
    end
    it "newアクションが実行されるか" do 
      get :new 
      expect(response).to render_template :new
    end 
    it "インスタンスが作成されるか" do 
      get :new 
      expect(assigns(:exhibit)).to be_a_new(Exhibit)
    end
  end

  describe 'GET #index' do
    before do
      login_user user
    end
    it "indexアクションが動くか" do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    before do
      login_user user
    end
    it "showアクションが動くか" do
      get :show, params: {id: exhibit.id}
      expect(response).to be_success
    end
  end

  describe "Get #edit" do
    before do
      login_user user
    end
    it "editアクションが動くか" do
      allow(controller).to receive(:current_user).and_return(user)
      get :edit, params: {id: exhibit.id}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    before do
      login_user user
    end
    it "データベースにデータが保存されるか" do
      # expect{
      #   post :create, exhibit: attributes_for(:exhibit)
      # }.to change(Exhibit, :count).by(1)
      expect {
        post :create, params: {
          exhibit: {
            name: "猫",
            price: "1000",
            status: "未使用に近い",
            description: "猫です",
            ship: "YOUメール",
            ship_fee: "送料込み",
            size: "",
            user_id: "1",
            buyer_id: "",
            shipment: "1日〜2日で発送",
            category_id: "28"
          }
        }
      }.to change(Exhibit, :count).by(1)
    end
  end
  describe "#destroy" do
    before do
      login_user user
    end
    it "商品を削除できるか" do
      allow(controller).to receive(:current_user).and_return(user)
      expect {
          delete :destroy, params: {id: exhibit_dummy.id}
        }.to change(Exhibit, :count).by(-1)
    end
  end
end
