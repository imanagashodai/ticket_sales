require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:generaluser) }
  
  it "成功例。adminは常にfalse。" do
    expect(user).to be_valid
    expect(user.admin).to be false
  end

  context "失敗例" do
    describe "名前" do
      it "空欄。" do
        user.name = ""
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
    end
    
    describe "Eメール" do
      it "空欄" do
        user.email = ""
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      
      it "重複" do
        user.save
        user2 = User.new(name: "Eメール", email: user.email, password: "wwwwwww3", password_confirmation: "wwwwwww3")
        user2.valid?
        expect(user2.errors[:email]).to include("はすでに存在します")
      end
      
      it "｢～@～.～｣で書かれてない" do
        user.email = "fff"
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
    end
    
    describe "パスワード" do
      context "「8~32文字」「半角英字と数字の混合」のいずれかを満たさない" do
        shared_examples_for '不正パスワード' do |password|
          it { 
            user.password = password
            user.valid?
            expect(user.errors[:password]).to include("は不正な値です")
          }
        end
      
        context "8文字未満" do
          it_behaves_like '不正パスワード', "123456a"
        end
        
        context "32文字より多い" do
          it_behaves_like '不正パスワード', "12345678901234567890123456789012q"
        end
        
        context "半角英字のみ" do
          it_behaves_like '不正パスワード', "abcdefgh"
        end
        
        context "数字のみ" do
          it_behaves_like '不正パスワード', "12345678"
        end
        
        context "半角英数字以外" do
          it_behaves_like '不正パスワード', "123456a@"
        end
      end
    end
  end
end