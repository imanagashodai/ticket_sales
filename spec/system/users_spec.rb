require 'rails_helper'

RSpec.describe '一般ユーザー機能', type: :system do
  describe "新規ユーザー登録機能" do
    let(:generaluser) { FactoryBot.build(:generaluser) }
    
    before do 
      visit new_user_path
      fill_in '名前', with: generaluser.name
      fill_in "Eメール ※｢～@～.～｣の形で", with: generaluser.email
      fill_in 'パスワード ※「8~32文字」かつ「半角英字と数字の混合」', with: generaluser.password
      fill_in 'パスワード(再入力)', with: generaluser.password_confirmation
    end
    
    it '成功の場合、ログイン画面へ遷移' do
      click_button '登録'
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert', text: 'ユーザー登録しました'
    end
    
    it "失敗の場合、登録画面のままバリデーションが表示。名前とEメールは値が残ったまま。" do
      fill_in "パスワード(再入力)", with: ""
      click_button '登録'
      expect(current_path).to eq users_path
      expect(page).to have_selector '.alert', text: '登録失敗。'
      expect(page).to have_field 'user_name', with: generaluser.name
      expect(page).to have_field 'user_email', with: generaluser.email
    end
  end
  
  describe "ログイン機能" do
    let(:generaluser) { FactoryBot.create(:generaluser) }
    
    before do 
      visit login_path
      fill_in "Eメール", with: generaluser.email
      fill_in 'パスワード', with: generaluser.password
    end
    
    it '成功の場合、トップ画面へ遷移。管理人画面へのリンクは表示されない。' do
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_selector '.alert', text: 'ログインしました'
      expect(page).not_to have_link '管理人画面'
    end
    
    it "失敗の場合、ログイン画面のままバリデーションが表示。Eメールは値が残ったまま。" do
      fill_in "パスワード", with: ""
      click_button 'ログイン'
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert', text: 'ログインに失敗しました'
      expect(page).to have_field 'email', with: generaluser.email
    end
  end
end