require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryBot.build(:cart) }
  
  it "成功例" do
    expect(cart).to be_valid
  end
  
  context "失敗例" do
    describe "チケットID" do
      it "空欄" do
        cart.ticket_id = ""
        cart.valid?
        expect(cart.errors[:ticket]).to include("を登録してください")
      end
      
      it "チケット未登録" do
        cart.ticket_id = 100
        cart.valid?
        expect(cart.errors[:ticket]).to include("を登録してください")
      end
      
      it "ユーザーと共に重複" do
        cart.save
        cart2 = Cart.new(ticket_id: cart.ticket_id, user_id: cart.user_id)
        cart2.valid?
        expect(cart2.errors[:ticket_id]).to include("はすでに存在します")
      end
    end
    
    describe "ユーザーID" do
      it "空欄" do
        cart.user_id = ""
        cart.valid?
        expect(cart.errors[:user]).to include("を登録してください")
      end
      
      it "ユーザー未登録" do
        cart.user_id = 100
        cart.valid?
        expect(cart.errors[:user]).to include("を登録してください")
      end
    end
  end
end