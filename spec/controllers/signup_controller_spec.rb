require 'rails_helper'

RSpec.describe SignupController, type: :controller do

  user = User.find(1)

  describe 'GET #index' do
    it "indexアクションが実行されるか" do 
      get :index
      expect(response).to be_success
    end 
  end

  describe 'GET #step1' do
    it "step1アクションが実行されるか" do 
      get :step1
      expect(response).to be_success
    end 
  end

  describe 'GET #step2' do
    it "step2アクションが実行されるか" do 
      get :step2
      expect(response).to be_success
    end 
  end

  describe 'GET #complete' do
    before do
      login_user user
    end
    it "completeアクションが実行されるか" do 
      get :complete
      expect(response).to be_success
    end 
  end

end
end