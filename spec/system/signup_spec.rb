require 'rails_helper'

describe 'signup', type: :system do
  before do
    visit signup_path
  end
  scenario 'invalid signup information' do
    expect {
    fill_in 'Name', with: '' 
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_button 'Create my account'
    }.to_not change{ User.count }
    expect(page).to have_css '#error_explanation'
    expect(page).to have_css '.alert'
  end
  scenario 'valid signup information' do
    expect {
    fill_in 'Name', with: 'testuser' 
    fill_in 'Email', with: 'test1@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    click_button 'Create my account'
    }.to change{ User.count }.by(1)
    user = User.last
    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'Welcome to the Insta App!'
    within '.navbar-nav' do
      expect(page).to_not have_link 'Log in', href: login_path
      click_link 'Account'
      expect(page).to have_link 'Log out', href: logout_path
      expect(page).to have_link 'Profile', href: user_path(user)
    end
  end
end
    
  
