require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user_validation' do
    let(:user) { FactoryBot.build(:user) }
    it 'is valid when valid params' do
      expect(user).to be_valid
    end
    it 'is invalid without name' do
      user.name = ''
      expect(user).to be_invalid
    end
    it 'is invalid without email' do
      user.email = ''
      expect(user).to be_invalid
    end
    it 'is invalid with name too long' do
      user.name = 'a' * 51
      expect(user).to be_invalid
    end
    it 'is valid with valid format email' do
      user.email = 'user@example.com'
      expect(user).to be_valid
      user.email = 'USER@foo.COM'
      expect(user).to be_valid
      user.email = 'A_US-ER@foo.bar.org'
      expect(user).to be_valid
      user.email = 'first.last@foo.jp'
      expect(user).to be_valid
      user.email = 'alice+bob@baz.cn'
      expect(user).to be_valid
    end     
      it 'is invalid with invaild format email' do
      user.email = 'user@example,com'
      expect(user).to be_invalid
      user.email = 'user_at_foo.org'
      expect(user).to be_invalid
      user.email = 'user.name@example.'
      expect(user).to be_invalid
      user.email = 'foo@bar_baz.com'
      expect(user).to be_invalid
      user.email = 'foo@bar+baz.com'
      expect(user).to be_invalid
    end
    it 'is invalid with not unique email' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end
    it 'email saved as lower-case' do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save!
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
    it 'is invalid with blank password' do
      user.password = user.password_confirmation = '' * 6
      expect(user).to be_invalid
    end
    it 'is invalid with password too short' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).to be_invalid
    end
    it 'associated microposts are destroyed' do
      user.save
      user.microposts.create!(content: "Lorem ipsum", 
                              picture: File.open("#{Rails.root}/public/images/kitten.jpg"))
      expect{ user.destroy }.to change{ Micropost.count }.by(-1)
    end
  end
  describe 'user_feed' do
    subject { user_a.feed }
    let(:user_a) { FactoryBot.create(:user)}
    let(:user_b) { FactoryBot.create(:user)}
    let(:user_c) { FactoryBot.create(:user)}
    before do
      @post_self = FactoryBot.create(:micropost, user:user_a)
      @post_following = FactoryBot.create(:micropost, user:user_b)
      @post_unfollow = FactoryBot.create(:micropost, user:user_c)
      user_a.follow(user_b)
    end
    it { is_expected.to include(@post_self) }
    it { is_expected.to include(@post_following) }
    it { is_expected.to_not include(@post_unfollow) }
  end
end



