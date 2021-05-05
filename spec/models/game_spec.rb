require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryBot.build(:game) }
  
  it "成功例" do
    expect(game).to be_valid
  end
  
  context "失敗例" do
    describe "ホーム球団ID" do
      it "空欄" do
        game.hometeam_id = ""
        game.valid?
        expect(game.errors[:hometeam]).to include("を登録してください")
      end
      
      it "ホーム球団未登録" do
        game.hometeam_id = 100
        game.valid?
        expect(game.errors[:hometeam]).to include("を登録してください")
      end
      
      it "ビジター球団と同じ" do
        game.hometeam_id = game.visitorteam_id
        game.valid?
        expect(game.errors[:hometeam]).to include("とビジター球団が同じです")
      end
    end
    
    describe "ビジター球団ID" do
      it "空欄" do
        game.visitorteam_id = ""
        game.valid?
        expect(game.errors[:visitorteam]).to include("を登録してください")
      end
      
      it "ビジター球団未登録" do
        game.visitorteam_id = 200
        game.valid?
        expect(game.errors[:visitorteam]).to include("を登録してください")
      end
    end
    
    describe "球場ID" do
      it "空欄" do
        game.ground_id = ""
        game.valid?
        expect(game.errors[:ground]).to include("を登録してください")
      end
      
      it "球場未登録" do
        game.ground_id = 100
        game.valid?
        expect(game.errors[:ground]).to include("を登録してください")
      end
    end
    
    describe "試合開始日時" do
      it "空欄" do
        game.datetime = ""
        game.valid?
        expect(game.errors[:datetime]).to include("を入力してください")
      end
      
      it "ホーム球団、ビジター球団、球場と共に重複" do
        game.save
        game2 = Game.new(datetime: game.datetime, hometeam_id: game.hometeam_id, visitorteam_id: game.visitorteam_id, ground_id: game.ground_id)
        game2.valid?
        expect(game2.errors[:datetime]).to include("はすでに存在します")
      end
    end
  end
end