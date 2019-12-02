require 'rails_helper'
describe User do
  describe '#create' do

    it "nicknameの値が4文字未満の時にバリデーションがかかるか" do
      user = build(:user, nickname: "aiu")
      user.valid?
      expect(user.errors[:nickname]).to include("is too short (minimum is 4 characters)")
    end

    it "nicknameの値が8文字より上の時にバリデーションがかかるか" do
      user = build(:user, nickname: "aiueokaki")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 8 characters)")
    end

    it "nicknameの値が空の時バリデーションがかかるか" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailの値が空の時バリデーションがかかるか" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "yearの値が空の時バリデーションがかかるか" do 
      user = build(:user, year: "")
      user.valid?
      expect(user.errors[:year]).to include("can't be blank")
    end
    
    it "monthの値が空の時バリデーションがかかるか" do 
      user = build(:user, month: "")
      user.valid?
      expect(user.errors[:month]).to include("can't be blank")
    end 

    it "dayの値が空の時バリデーションがかかるか" do 
      user = build(:user, day: "")
      user.valid?
      expect(user.errors[:day]).to include("can't be blank")
    end 

    it "名前入力の項目でひらがなと漢字以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, first_name_kanji: "asdadafa")
      user.valid?
      expect(user.errors[:first_name_kanji]).to include("is invalid")
    end 

    it "ひらがなと漢字以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kanji: "adas")
      user.valid?
      expect(user.errors[:family_name_kanji]).to include("is invalid")
    end

    it "カタカナ以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kana: "二郎")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("is invalid")
    end 

    it "カタカナ以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kana: "太郎")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("is invalid")
    end 
   
    it "passwordの値が空の時バリデーションがかかるか" do 
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
   
    it "passwordの値が6文字未満の時にバリデーションがかかるか" do 
      user = build(:user, password: 12345)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end
end
end
