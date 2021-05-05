require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { FactoryBot.build(:ticket) }
  
  it "成功例" do
    expect(ticket).to be_valid
  end
  
  context "失敗例" do
    describe "座席ID" do
      it "空欄" do
        ticket.seat_id = ""
        ticket.valid?
        expect(ticket.errors[:seat]).to include("を登録してください")
      end
      
      it "座席未登録" do
        ticket.seat_id = 100
        ticket.valid?
        expect(ticket.errors[:seat]).to include("を登録してください")
      end
      
      it "座席と試合、それぞれの球場が不一致" do
        seat2 = FactoryBot.create(:seat2)
        ticket.seat_id = seat2.id
        ticket.valid?
        expect(ticket.errors[:seat]).to include("の球場が、試合の球場と異なります")
      end
    end
    
    describe "試合ID" do
      it "空欄" do
        ticket.game_id = ""
        ticket.valid?
        expect(ticket.errors[:game]).to include("を登録してください")
      end
      
      it "試合未登録" do
        ticket.game_id = 100
        ticket.valid?
        expect(ticket.errors[:game]).to include("を登録してください")
      end
      
      it "座席と共に重複" do
        ticket.save
        ticket2 = Ticket.new(seat_id: ticket.seat_id, game_id: ticket.game_id)
        ticket2.valid?
        expect(ticket2.errors[:game_id]).to include("はすでに存在します")
      end
    end
  end
end