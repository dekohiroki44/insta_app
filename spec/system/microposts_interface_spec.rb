require 'rails_helper'

describe 'microposts_interface', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create(:micropost, user: user, content: 'test')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit root_path
  end
  it 'is invlid with invalid post' do
    expect{ 
    fill_in with: ''
    click_button 'Post'
    }.to_not change{ Micropost.count }
    expect(page).to have_css '#error_explanation'
  end
  it 'is valid with valid post' do
    content = 'This micropost really ties the room together'
    expect{ 
    fill_in with: 'This micropost really ties the room together'
    click_button 'Post'
    }.to change{ Micropost.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content content
  end
  it 'is valid delete a micropost' do
    expect(page).to have_content 'test' 
    click_link 'delete' 
    page.accept_confirm
    expect(page).to_not have_content 'test' 
  end
end