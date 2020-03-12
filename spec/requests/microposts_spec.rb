require 'rails_helper'

RSpec.describe "microposts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @otheruser = FactoryBot.create(:user, name: 'otheruser', email: 'other@example.com')
    @micropost = FactoryBot.create(:micropost, user: @user)
  end
  context 'when not logged in' do
    it 'redirect create' do
      expect{ post microposts_path params: { micropost: { content: "Lorem ipsum" } } }.to_not change{ Micropost.count }
      expect(response).to redirect_to login_path
    end
    it 'redirect destroy' do
      expect{ delete micropost_path(@micropost) }.to_not change{ Micropost.count }
      expect(response).to redirect_to login_path
    end
  end
  context 'when logged in wrong user' do
    before do
      log_in_as(@otheruser)
    end
    it 'redirect destroy' do
      expect{ delete micropost_path(@micropost) }.to_not change{ Micropost.count }
      expect(response).to redirect_to root_path
    end
  end
end