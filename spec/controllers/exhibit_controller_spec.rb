require 'rails_helper'

RSpec.describe ExhibitController, type: :controller do
  describe 'GET #new' do
    before do
      get :new 
    end 
    it "newアクションが実行されるか" do 
      expect(response).to render_template :new
    end 
    it "インスタンスが作成されるか" do 
      expect(assigns(:exhibit)).to be_a_new(Exhibit)
  end
end

  describe 'GET #index' do
    it "indexアクションが動くか" do
      get :index
      expect(response).to render_template :index
    end
    end

    describe 'Post #create' do
      context '有効なパラメータの場合' do
        before do
          @Exhibit = attributes_for(:exhibit, {name: "たこやき"})
        end
        it 'データベースに新しいデータが保存される' do
          expect{
            post :create, exhibit: @Exhibit
          }.to change(Exhibit, :count).by(1)
        end
        
      end
    end
  end