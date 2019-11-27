require 'rails_helper'
describe User do
  describe '#create' do

    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a year" do 
      user = build(:user, year: "")
      user.valid?
      expect(user.errors[:year]).to include("can't be blank")
    end
    it "is invalid without a month" do 
      user = build(:user, month: "")
      user.valid?
      expect(user.errors[:month]).to include("can't be blank")
    end 
    it "is invalid without a year" do 
      user = build(:user, day: "")
      user.valid?
      expect(user.errors[:day]).to include("can't be blank")
    end 

  end
end