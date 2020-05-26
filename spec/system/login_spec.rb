require 'rails_helper'

describe 'login', type: :system do
  before do
    visit login_path
  end
  context 'with invalid information' do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログインする'
    end
    scenario 'flash messages is presence' do
      expect(page).to have_selector('.alert-danger', text: 'Invalid email/password combination')
      expect(page).to have_current_path login_path
    end
    scenario 'flash message is not presence when next view' do
      visit root_path
      expect(page).to_not have_selector('.alert-danger', text: 'Invalid email/password combination')
    end
  end
  context 'with valid information' do
    let(:user) { FactoryBot.create(:user) }
    before do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログインする'
    end
    scenario 'correct links are displayed when log in' do
      expect(page).to_not have_link 'ログイン', href: login_path
      expect(page).to have_link '全てのユーザー', href: users_path
      click_link 'アカウント'
      expect(page).to have_link 'ログアウト', href: logout_path
      expect(page).to have_link 'マイ ページ', href: user_path(user)
    end
    scenario 'and log out' do
      click_link 'アカウント'
      click_link 'ログアウト' 
      expect(current_path).to eq root_path
      expect(page).to have_link 'ログイン', href: login_path
      expect(page).to_not have_link 'ログアウト', href: logout_path
      expect(page).to_not have_link 'プロフィール', href: user_path(user)
    end
  end
end



