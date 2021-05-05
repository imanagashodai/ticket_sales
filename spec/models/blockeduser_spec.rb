require 'rails_helper'

RSpec.describe Blockeduser, type: :model do
  let(:blockeduser) { FactoryBot.build(:blockeduser) }
  
  it "成功例" do
    expect(blockeduser).to be_valid
  end
  
  context "失敗例" do
    describe "ユーザーID" do
      it "空欄" do
        blockeduser.user_id = ""
        blockeduser.valid?
        expect(blockeduser.errors[:user]).to include("を登録してください")
      end
      
      it "ユーザー未登録" do
        blockeduser.user_id = 100
        blockeduser.valid?
        expect(blockeduser.errors[:user]).to include("を登録してください")
      end
      
      it "重複" do
        blockeduser.save
        blockeduser2 = Blockeduser.new(user_id: blockeduser.user_id)
        blockeduser2.valid?
        expect(blockeduser2.errors[:user_id]).to include("はすでに存在します")
      end
    end
  end
end