require 'rails_helper'

RSpec.describe Seatgroup, type: :model do
  let(:seatgroup) { FactoryBot.build(:seatgroup) }
  
  it "成功例" do
    expect(seatgroup).to be_valid
  end
  
  context "失敗例" do
    describe "座席群名" do
      it "空欄" do
        seatgroup.name = ""
        seatgroup.valid?
        expect(seatgroup.errors[:name]).to include("を入力してください")
      end
      
      it "球場、値段と共に重複" do
        seatgroup.save
        seatgroup2 = Seatgroup.new(name: seatgroup.name, ground_id: seatgroup.ground_id, price: seatgroup.price)
        seatgroup2.valid?
        expect(seatgroup2.errors[:name]).to include("はすでに存在します")
      end
    end
    
    describe "値段" do
      it "空欄" do
        seatgroup.price = ""
        seatgroup.valid?
        expect(seatgroup.errors[:price]).to include("を入力してください")
      end
    end
    
    describe "球場ID" do
      it "空欄" do
        seatgroup.ground_id = ""
        seatgroup.valid?
        expect(seatgroup.errors[:ground]).to include("を登録してください")
      end
      
      it "球場未登録" do
        seatgroup.ground_id = 100
        seatgroup.valid?
        expect(seatgroup.errors[:ground]).to include("を登録してください")
      end
    end
  end
end