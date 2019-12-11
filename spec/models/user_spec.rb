require 'rails_helper'
describe User do
  describe '#create' do

    it "nicknameの値が4文字未満の時にバリデーションがかかるか" do
      user = build(:user, nickname: "aiu")
      user.valid?
      expect(user.errors[:nickname]).to include("は4文字以上で入力してください")
    end

    it "nicknameの値が16文字より上の時にバリデーションがかかるか" do
      user = build(:user, nickname: "aiueokakikukekosa")
      user.valid?
      expect(user.errors[:nickname]).to include("は16文字以内で入力してください")
    end

    it "nicknameの値が空の時バリデーションがかかるか" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailの値が空の時バリデーションがかかるか" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "yearの値が空の時バリデーションがかかるか" do 
      user = build(:user, year: "")
      user.valid?
      expect(user.errors[:year]).to include("を入力してください")
    end
    
    it "monthの値が空の時バリデーションがかかるか" do 
      user = build(:user, month: "")
      user.valid?
      expect(user.errors[:month]).to include("を入力してください")
    end 

    it "dayの値が空の時バリデーションがかかるか" do 
      user = build(:user, day: "")
      user.valid?
      expect(user.errors[:day]).to include("を入力してください")
    end 

    it "名前入力の項目でひらがなと漢字以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, first_name_kanji: "asdadafa")
      user.valid?
      expect(user.errors[:first_name_kanji]).to include("は不正な値です")
    end 

    it "ひらがなと漢字以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kanji: "adas")
      user.valid?
      expect(user.errors[:family_name_kanji]).to include("は不正な値です")
    end

    it "カタカナ以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kana: "二郎")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end 

    it "カタカナ以外を入力した時にバリデーションがかかるか" do 
      user = build(:user, family_name_kana: "太郎")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end 
   
    it "passwordの値が空の時バリデーションがかかるか" do 
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
   
    it "passwordの値が6文字未満の時にバリデーションがかかるか" do 
      user = build(:user, password: 12345)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "phone_numberの値が10文字未満の時にバリテーションがかかるか" do
      user = build(:user, phone_number: 123456789)
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "phone_numberの値が12文字以上の時にバリテーションがかかるか" do
      user = build(:user, phone_number: 123456789012)
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "数字以外を入力した時にバリデーションがかかるか" do
      user = build(:user, phone_number: "abcdefghijk")
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "userを保存できるか" do
      expect(User.create({
        nickname: "testuser",
        email: "ddd@ddd.com",
        password: "1234567",
        icon: "",
        comment: "",
        year: 1999,
        month: 12,
        day: 31,
        family_name_kanji: "田中",
        first_name_kanji: "太郎",
        family_name_kana: "タナカ",
        first_name_kana: "タロウ",
        phone_number: "12345678901",
        encrypted_password: "aaaaaaaaaaa"
        })
      ).to change(User, :count).by(1)
    end
  end
end
