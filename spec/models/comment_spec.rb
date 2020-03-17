require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_a) { FactoryBot.create(:user)}
  let(:user_b) { FactoryBot.create(:user)}
  let(:micropost) { FactoryBot.create(:micropost, user: user_b)}
  let(:comment) { FactoryBot.build(:comment, user: user_a, micropost: micropost) }
  it 'is valid with full column' do
    expect(comment).to be_valid
  end
  it 'is invalid without content' do
    comment.content = ''
    expect(comment).to be_invalid
  end
end
