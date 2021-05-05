require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { FactoryBot.build(:team) }
  
  context "成功例" do
    it "基本形" do
      expect(team).to be_valid
    end
    
    it "本拠地未登録でも可" do
      team.ground_id = ""
      expect(team).to be_valid
    end
  end
  
  context "失敗例" do
    describe "球団名" do
      it "空欄" do
        team.name = ""
        team.valid?
        expect(team.errors[:name]).to include("を入力してください")
      end
      
      it "本拠地と共に重複" do
        team.save
        team2 = Team.new(name: team.name, ground_id: team.ground_id)
        team2.valid?
        expect(team2.errors[:name]).to include("はすでに存在します")
      end
    end
  end
end