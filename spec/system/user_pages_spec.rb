require 'rails_helper'

describe 'user_pages', type: :system do
  subject { page }
  describe 'index' do
    let(:admin) { FactoryBot.create(:user, admin: true) }
    let(:notadmin) { FactoryBot.create(:user, admin: false) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
      visit users_path
    end
    context 'when logged in as admin' do
      let(:login_user) { admin }
      before(:all) { 30.times { FactoryBot.create(:user) } }
      after(:all)  { User.delete_all }
      it { is_expected.to have_title 'All users' }
      it { is_expected.to have_css '.pagination' }
      it 'list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_link user.name, href: user_path(user) 
          unless user.admin
            expect(page).to have_link '削除', href: user_path(user) 
          end
        end
      end
    end
    context 'when logged in as not admin' do
      let(:login_user) { notadmin }
      before(:all) { 30.times { FactoryBot.create(:user) } }
      after(:all)  { User.delete_all }
      it { is_expected.to_not have_link '削除' }
    end
  end
  describe 'following/follwers' do
    let(:user) { FactoryBot.create(:user, email: 'user@example.com') }
    let(:other_user) { FactoryBot.create(:user, email: 'other@example.com') }
    before do
      user.follow(other_user)
      other_user.follow(user)
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログインする'
    end
    context 'visit following page' do
      before do
        visit following_user_path(user)
      end
      it 'following is not empty' do
        expect(user.following).to_not be_empty
      end
      it { is_expected.to have_content user.following.count }
      it { is_expected.to have_link other_user.name, href: user_path(other_user) }
    end
    context 'visit followers page' do
      before do
        visit followers_user_path(user)
      end
      it 'followers is not empty' do
        expect(user.followers).to_not be_empty
      end
      it { is_expected.to have_content user.followers.count }
      it { is_expected.to have_link other_user.name, href: user_path(other_user) }
    end
  end
end