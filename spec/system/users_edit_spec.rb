require 'rails_helper'

describe 'users_edit with friendly forwarding', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    visit edit_user_path(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
  scenario 'invalid edit information' do
    expect(current_path).to eq edit_user_path(user)
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_button 'Save changes'
    expect(user.reload.name).to eq user.name
    expect(page).to have_selector('.alert', text: 'The form contains 4 errors.') 
  end
  scenario 'valid edit information' do
    expect(current_path).to eq edit_user_path(user)
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_button 'Save changes'
    expect(page).to have_selector('.alert')
    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq 'Foo Bar'
    expect(user.reload.email).to eq 'foo@bar.com'
  end
end