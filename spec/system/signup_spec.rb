require 'rails_helper'

describe 'signup', type: :system do
  before do
    visit signup_path
  end
  scenario 'invalid signup information' do
    expect {
    fill_in '名前', with: '' 
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    fill_in 'パスワード（確認）', with: ''
    click_button '登録する'
    }.to_not change{ User.count }
    expect(page).to have_css '#error_explanation'
    expect(page).to have_css '.alert'
  end
  scenario 'valid signup information' do
    expect {
    fill_in '名前', with: 'testuser' 
    fill_in 'メールアドレス', with: 'test1@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'
    click_button '登録する'
    }.to change{ User.count }.by(1)
    user = User.last
    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'ようこそInsta Appへ'
    within '.navbar-nav' do
      expect(page).to_not have_link 'ログイン', href: login_path
      click_link 'アカウント'
      expect(page).to have_link 'ログアウト', href: logout_path
      expect(page).to have_link 'マイ ページ', href: user_path(user)
    end
  end
end
    
  
