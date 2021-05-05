require 'rails_helper'

RSpec.describe Seat, type: :model do
  let(:seat) { FactoryBot.build(:seat) }
  
  it "成功例" do
    expect(seat).to be_valid
  end
  
  context "失敗例" do
    describe "座席群ID" do
      it "空欄" do
        seat.seatgroup_id = ""
        seat.valid?
        expect(seat.errors[:seatgroup]).to include("を登録してください")
      end
      
      it "座席群未登録" do
        seat.seatgroup_id = 100
        seat.valid?
        expect(seat.errors[:seatgroup]).to include("を登録してください")
      end
    end
    
    describe "座席名" do
      it "空欄" do
        seat.name = ""
        seat.valid?
        expect(seat.errors[:name]).to include("を入力してください")
      end
      
      it "座席群と共に重複" do
        seat.save
        seat2 = Seat.new(seatgroup_id: seat.seatgroup_id, name: seat.name)
        seat2.valid?
        expect(seat2.errors[:name]).to include("はすでに存在します")
      end
    end
  end
end