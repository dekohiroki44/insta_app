require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:micropost_a) {FactoryBot.create(:micropost, user: user, created_at: 10.minutes.ago) }
  let!(:micropost_b) {FactoryBot.create(:micropost, user: user, created_at: 3.years.ago) }
  let!(:micropost_c) {FactoryBot.create(:micropost, user: user, created_at: 2.hours.ago) }
  let!(:micropost_d) {FactoryBot.create(:micropost, user: user, created_at: Time.zone.now) }
  it 'is valid with valid info' do
    expect(micropost_a).to be_valid
  end
  it 'is invalid without user id' do
    micropost_a.user_id = nil
    expect(micropost_a).to be_invalid
  end
  it 'is invalid without content' do
    micropost_a.content = ''
    expect(micropost_a).to be_invalid
  end
  it 'is invalid with content longer than 140 characters' do
    micropost_a.content = 'a' *141
    expect(micropost_a).to be_invalid
  end
  it 'have the right microposts in the right order' do
    expect(user.microposts.to_a).to eq [micropost_d, micropost_a, micropost_c, micropost_b]
  end
end

