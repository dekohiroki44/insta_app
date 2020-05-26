require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.build(:like, user_id: @user.id, micropost_id: @micropost.id) }
  before do
    @user = FactoryBot.create(:user)
    @micropost = FactoryBot.create(:micropost)
  end
  describe 'validation' do
    it 'with full column' do
      expect(like).to be_valid
    end
    it 'without user_id' do
      like.user_id = nil
      expect(like).to be_invalid
    end
    it 'without user_id' do
      like.micropost_id = nil
      expect(like).to be_invalid
    end
  end
end
