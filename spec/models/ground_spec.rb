require 'rails_helper'

RSpec.describe User, type: :model do
  let(:ground) { FactoryBot.build(:ground) }
  
  it "成功例" do
    expect(ground).to be_valid
  end

  context "失敗例" do
    describe "名前" do
      it "空欄" do
        ground.name = ""
        ground.valid?
        expect(ground.errors[:name]).to include("を入力してください")
      end
    
      it "重複" do
        ground.save
        ground2 = Ground.new(name: ground.name)
        ground2.valid?
        expect(ground2.errors[:name]).to include("はすでに存在します")
      end
    end
  end
end