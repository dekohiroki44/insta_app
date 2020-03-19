require 'rails_helper'

describe 'microposts_interface', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create(:micropost, user: user, picture: File.open("#{Rails.root}/public/images/kitten.jpg"))
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit new_micropost_path
  end
  it 'is invlid with invalid post' do
    expect{ 
    click_button 'Post'
    }.to_not change{ Micropost.count }
    expect(page).to have_css '#error_explanation'
  end
  it 'is valid with valid post' do
    expect{ 
    attach_file "#{Rails.root}/public/images/kitten.jpg"
    click_button 'Post'
    }.to change{ Micropost.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_selector("img[src$='kitten.jpg']")
  end
  it 'is valid delete a micropost' do
    visit root_path
    expect(page).to have_selector("img[src$='kitten.jpg']") 
    click_link '削除' 
    page.accept_confirm
    expect(page).to_not have_selector("img[src$='kitten.jpg']")
  end
end