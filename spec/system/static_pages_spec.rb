require 'rails_helper'

describe 'StaticPages', type: :system do
  subject {page}
  context 'when not logged in at home' do
    before do
      visit root_path
    end
    it { is_expected.to have_title 'Insta App' }
    it { is_expected.to have_link href: root_path }
    it { is_expected.to have_link href: signup_path }
    it { is_expected.to_not have_link href: notifications_path }
  end
end

