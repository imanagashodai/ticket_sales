require 'rails_helper'

RSpec.describe '一般ユーザー機能', type: :system do
  let!(:generaluser) { FactoryBot.create(:generaluser) }
  
  describe "新規ユーザー登録機能" do
    before do 
      visit new_user_path
      fill_in '名前', with: 'テスト1'
      fill_in "Eメール ※｢～@～.～｣の形で", with: "example1@user.com"
      fill_in 'パスワード ※「8~32文字」かつ「半角英字と数字の混合」', with: 'Example1'
      fill_in 'パスワード(再入力)', with: 'Example1'
    end
    
    context "ルール通りに入力した時" do
      it '正常に登録され、ログイン画面へ遷移' do
        click_button '登録'
        expect(page).to have_selector 'h1', text: 'ログイン画面'
        expect(page).to have_selector '.alert', text: 'ユーザー登録しました'
      end
    end
    
    context "ルール通りに入力しなかった時" do
      shared_examples_for '登録失敗し、登録画面のままバリデーションが表示される。' do |fillin_with, val_text|
        it { 
          fill_in fillin_label, with: fillin_with
          click_button '登録'
          expect(page).to have_selector 'h1', text: 'ユーザー登録'
          expect(page).to have_selector '.alert', text: '登録失敗。'
          expect(page).to have_selector '.alert', text: val_text
        }
      end
      
      describe "名前" do
        let(:fillin_label) { "名前" }
        
        context "空欄にした場合" do
          it_behaves_like '登録失敗し、登録画面のままバリデーションが表示される。', "", "名前を入力してください。"
        end
      end
      
      describe "Eメール" do
        let(:fillin_label) { "Eメール ※｢～@～.～｣の形で" }
        
        context "空欄にした場合" do
          it_behaves_like '登録失敗し、登録画面のままバリデーションが表示される。', "", "Eメールを入力してください。"
        end
        
        context "他ユーザーと重複した場合" do
          it_behaves_like '登録失敗し、登録画面のままバリデーションが表示される。', FactoryBot.build(:generaluser).email, "Eメールはすでに存在します。"
        end
        
        context "Eメールが｢～@～.～｣で書かれてない場合" do
          it_behaves_like '登録失敗し、登録画面のままバリデーションが表示される。', "mistake", "Eメールは不正な値です。"
        end
      end
      
      describe "パスワード" do
        shared_examples_for 'パスワードのバリデーションが表示される。' do |password, password_confirmation, val_text|
          it { 
            fill_in 'パスワード ※「8~32文字」かつ「半角英字と数字の混合」', with: password
            fill_in 'パスワード(再入力)', with: password_confirmation
            click_button '登録'
            expect(page).to have_selector 'h1', text: 'ユーザー登録'
            expect(page).to have_selector '.alert', text: '登録失敗。'
            expect(page).to have_selector '.alert', text: val_text
          }
        end
        
        context "「8~32文字」「半角英字と数字の混合」のいずれかを満たさない場合" do
          context "8文字未満" do
            it_behaves_like 'パスワードのバリデーションが表示される。', "ssssss1", "ssssss1", "パスワードは不正な値です。"
          end
          
          context "32文字より多い" do
            it_behaves_like 'パスワードのバリデーションが表示される。', "ssssssssssssssssssssssssssssssss1", "ssssssssssssssssssssssssssssssss1", "パスワードは不正な値です。"
          end
          
          context "半角英字のみ" do
            it_behaves_like 'パスワードのバリデーションが表示される。', "ssssssss", "ssssssss", "パスワードは不正な値です。"
          end
          
          context "数字のみ" do
            it_behaves_like 'パスワードのバリデーションが表示される。', "12345678", "12345678", "パスワードは不正な値です。"
          end
          
          context "半角英数字以外" do
            it_behaves_like 'パスワードのバリデーションが表示される。', "a234567八", "a234567八", "パスワードは不正な値です。"
          end
        end
        
        context "パスワードとパスワード(再入力)が一致しない場合" do
          it_behaves_like 'パスワードのバリデーションが表示される。', "1234567q", "1234567w", "パスワード(再入力)とパスワードの入力が一致しません。"
        end
      end
    end
  end
end