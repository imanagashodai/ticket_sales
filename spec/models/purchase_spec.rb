require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:purchase) { FactoryBot.build(:purchase) }
  
  it "成功例" do
    expect(purchase).to be_valid
  end
  
  context "失敗例" do
    describe "チケットID" do
      it "空欄" do
        purchase.ticket_id = ""
        purchase.valid?
        expect(purchase.errors[:ticket]).to include("を登録してください")
      end
      
      it "チケット未登録" do
        purchase.ticket_id = 100
        purchase.valid?
        expect(purchase.errors[:ticket]).to include("を登録してください")
      end
      
      it "重複" do
        purchase.save
        purchase2 = Purchase.new(ticket_id: purchase.ticket_id, user_id: 20)
        purchase2.valid?
        expect(purchase2.errors[:ticket_id]).to include("はすでに存在します")
      end
    end
    
    describe "ユーザーID" do
      it "空欄" do
        purchase.user_id = ""
        purchase.valid?
        expect(purchase.errors[:user]).to include("を登録してください")
      end
      
      it "ユーザー未登録" do
        purchase.user_id = 100
        purchase.valid?
        expect(purchase.errors[:user]).to include("を登録してください")
      end
    end
  end
end