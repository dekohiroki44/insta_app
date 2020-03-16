require 'rails_helper'

RSpec.describe "likes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @micropost = FactoryBot.create(:micropost)
  end
  context 'when not logged in' do
    it 'is redirect require logged in at create' do
      expect{ post likes_path }.to_not change{ Like.count }
      expect(response).to redirect_to login_path
    end
    it 'is redirect require logged in at destroy' do
      @like = Like.create(user_id: @user.id, micropost_id: @micropost.id)
      expect{ delete like_path(@like) }.to_not change{ Like.count }
      expect(response).to redirect_to login_path
    end
  end
  context 'when logged in' do
    before do
      log_in_as @user
    end
    it 'create with Ajax' do
      expect{ 
      post likes_path, xhr: true, params: { user_id: @user.id, micropost_id: @micropost.id}
      }.to change{ @micropost.likes.count }.by(1)
    end
    it 'destroy with Ajax' do
      like = Like.create(user_id: @user.id, micropost_id: @micropost.id)
      expect{
      delete like_path(like), xhr: true
      }.to change{ @micropost.likes.count }.by(-1)
    end
  end
end