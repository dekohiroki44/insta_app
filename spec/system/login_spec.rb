require 'rails_helper'

describe 'login', type: :system do
  before do
    visit login_path
  end
  context 'with invalid information' do
    before do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
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
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
    scenario 'correct links are displayed when log in' do
      expect(page).to_not have_link 'Log in', href: login_path
      expect(page).to have_link 'Users', href: users_path
      click_link 'Account'
      expect(page).to have_link 'Log out', href: logout_path
      expect(page).to have_link 'Profile', href: user_path(user)
    end
    scenario 'and log out' do
      click_link 'Account'
      click_link 'Log out' 
      expect(current_path).to eq root_path
      expect(page).to have_link 'Log in', href: login_path
      expect(page).to_not have_link 'Log out', href: logout_path
      expect(page).to_not have_link 'Profile', href: user_path(user)
    end
  end
end



