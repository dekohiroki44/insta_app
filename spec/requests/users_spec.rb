require 'rails_helper'

RSpec.describe "users", type: :request do
  before do
  @user = FactoryBot.create(:user)
  @other = FactoryBot.create(:user, name: 'otheruser', email: 'other@example.com') 
  end
  context 'when not logged in' do
    it 'redirect index' do
      get users_path
      expect(response).to redirect_to login_path
    end
    it 'redirect edit' do
      get edit_user_path(@user)
      expect(response).to redirect_to login_path
    end
    it 'redirect update' do
      patch user_path(@user)
      expect(response).to redirect_to login_path
    end
    it 'redirect destroy' do
      expect{ delete user_path(@user)}.to_not change{ User.count }
      expect(response).to redirect_to login_path
    end
    it 'redirect following' do
      get following_user_path(@user)
      expect(response).to redirect_to login_path
    end
    it 'redirect followers' do
      get followers_user_path(@user)
      expect(response).to redirect_to login_path
    end
  end
  context 'when logged in as wrong user' do
    before do
      log_in_as @other
    end
    it 'redirect edit' do
      get edit_user_path(@user)
      expect(response).to redirect_to root_path
    end
    it 'redirect update' do
      patch user_path(@user)
      expect(response).to redirect_to root_path
    end
  end
  context 'when not admin logged in' do
    before do
      log_in_as @other
    end
    it 'otheruser is not admin' do
      expect(@other.reload.admin).to be_falsey
    end
    it 'should not allow the admin attribute to be edited via the web' do
      patch user_path(@other), params: {user: { password:@other.password, password_confirmation: @other.password_confirmation, admin: true } }
      expect(@other.reload.admin).to be_falsey
    end
  end
end