require 'rails_helper'

RSpec.describe "relationships", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end
  context 'when not logged in' do
    it 'is redirect require logged in at create' do
      expect{ post relationships_path }.to_not change{ Relationship.count }
      expect(response).to redirect_to login_path
    end
    it 'is redirect require logged in at destroy' do
      @relationship = Relationship.create(followed_id: @user.id, follower_id: @other_user.id)
      expect{ delete relationship_path(@relationship) }.to_not change{ Relationship.count }
      expect(response).to redirect_to login_path
    end
  end
  context 'when logged in as @user' do
    before do
      log_in_as @user
    end
    it 'follow a user with standard way' do
      expect{ 
      post relationships_path, params:{ followed_id: @other_user.id }
      }.to change{ @user.following.count }.by(1)
    end
    it 'follow a user with Ajax' do
      expect{ 
      post relationships_path, xhr: true, params:{ followed_id: @other_user.id }
      }.to change{ @user.following.count }.by(1)
    end
    it 'unfollow a user with standard way' do
      @user.follow(@other_user)
      relationship = @user.active_relationships.find_by(followed_id: @other_user)
      expect{ 
      delete relationship_path(relationship)
      }.to change{ @user.following.count }.by(-1)
    end
    it 'unfollow a user with Ajax' do
      @user.follow(@other_user)
      relationship = @user.active_relationships.find_by(followed_id: @other_user)
      expect{ 
      delete relationship_path(relationship), xhr: true
      }.to change{ @user.following.count }.by(-1)
    end
  end
end