require 'rails_helper'

RSpec.describe SignupController, type: :controller do

  describe 'GET #index' do
    it "indexアクションが動くか" do
      get :index
      expect(response).to render_template :index
    end
 end

  describe 'GET #new' do
    it "step1アクションが動くか" do
      get :step1
      expect(response).to render_template :step1
    end
  end


   describe 'GET #step1' do
     it "新しいインスタンスが作成されるか" do
     get :step1
     expect(assigns(:user)).to be_a_new(User)
  end
  end
end


describe "get #step1" do
it "レスポンスが成功すること" do
  get :step1
  expect(response).to be_successful
end

#200レスポンスは成功というステート
it "200レスポンスを返すこと" do
  get :step1
  expect(response).to have_http_status "200"
end
end

describe "#step1_validates" do
context "有効なデータの場合" do 
  #　同じ処理はsubjectを使うことでｄｒｙにし同じデータを使っているとわかりやすくする
  subject {
    user_params = attributes_for(:user)
    #post　:アクション名, params: { パラメータ名: "値"}, session: { session名: "値" } でデータを指定できる
    post :step1_validates, params: { user: user_params},
                            session: {
                              nickname: "tanegashiman",
                              email: "kkk@gmail.com",
                              password: "123456a",
                              password_confirmation: "123456a",
                              lastname: "向井",
                              firstname: "治",
                              lastname_kana: "ムカイ",
                              firstname_kana: "オサム",
                              birthday_year: 2018,
                              birthday_month: 12,
                              birthday_day: 31
                            }
  }
   #200レスポンスはリダイレクト成功というステート
  it "302レスポオンスを返すこと" do
    #設定したsubjectはこのように使う
    subject
    expect(response).to have_http_status "302"
  end

  it "電話番号確認ページにリダイレクトすること" do
    subject
    expect(response).to redirect_to step2_signups_path
  end
end

context "無効なデータの場合" do
  subject {
    #無効なデータのときは処理の流れを理解しているとスムーズに進む
    user_params = attributes_for(:user, nickname: "")
    post :step1_validates, params: { user: user_params},
                          session: {
                            nickname: '',
                            email: "kkk@gmail.com",
                            password: "123456a",
                            password_confirmation: "123456a",
                            lastname: "向井",
                            firstname: "治",
                            lastname_kana: "ムカイ",
                            firstname_kana: "オサム",
                            birthday_year: 2018,
                            birthday_month: 12,
                            birthday_day: 31
                          }
  }

  it "200レスポオンスを返すこと" do
    subject
    expect(response).to have_http_status "200"
  end

  it "step1にrenderすること" do
    subject
    expect(response).to render_template :step1
  end
end

describe "get #step2" do
before do
# ここで定義しないとsessionがないと怒られる
user_params = attributes_for(:user)
session[:nickname] = user_params[:nickname]
session[:email] = user_params[:email]
session[:password] = user_params[:password_confirmation]
session[:password_confirmation] = user_params[:password_confirmation]
session[:lastname] = user_params[:lastname]
session[:firstname] = user_params[:firstname]
session[:lastname_kana] = user_params[:lastname_kana]
session[:firstname_kana] = user_params[:firstname_kana]
session[:birthday_year] = user_params[:birthday_year]
session[:birthday_month] = user_params[:birthday_month]
session[:birthday_day] = user_params[:birthday_day]
end
it "レスポンスが成功すること" do
  get :step2
  expect(response).to be_successful
end

it "200レスポンスを返すこと" do
  get :step2
  expect(response).to have_http_status "200"
end
end

describe "create" do
context "有効なデータの場合" do
  subject {
    user_params = attributes_for(:user)
    post :create, params: { user: user_params},
                  session: {
                    nickname: "tanegashiman",
                    email: "kkk@gmail.com",
                    password: "123456a",
                    password_confirmation: "123456a",
                    lastname: "向井",
                    firstname: "治",
                    lastname_kana: "ムカイ",
                    firstname_kana: "オサム",
                    birthday_year: 2018,
                    birthday_month: 12,
                    birthday_day: 31
                  }
  }
  it "302レスポンスを返すこと" do
    subject
    expect(response).to have_http_status "302"
  end

  it "送付先登録ページにリダイレクトされること" do
    subject
    expect(response).to redirect_to new_address_path
  end

  it "保存することができる" do
    user_params = attributes_for(:user)
    expect do
      subject
    end.to change { User.count }.by(1)
  end
end

context "無効なデータの場合" do
  subject {
    user_params = attributes_for(:user)
    post :create, params: { user: user_params},
                session: {
                  nickname: "",
                  email: "kkk@gmail.com",
                  password: "123456a",
                  password_confirmation: "123456a",
                  lastname: "向井",
                  firstname: "治",
                  lastname_kana: "ムカイ",
                  firstname_kana: "オサム",
                  birthday_year: 2018,
                  birthday_month: 12,
                  birthday_day: 31
                }
  }
  it "200レスポンスを返すこと" do
    subject
    expect(response).to have_http_status "200"
  end

  it "step2にrenderされること" do
    subject
    expect(response).to render_template :step2
  end

  it "保存することができない" do
    expect do
      subject
    end.to change { User.count }.by(0)
  end
end
end
end