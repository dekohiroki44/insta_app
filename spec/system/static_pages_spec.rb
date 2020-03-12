require 'rails_helper'

describe 'StaticPages',type: :system do
  describe 'Home' do
    before do
      visit '/'
    end

    it 'topページでのタイトルの表示' do
      expect(page).to have_title 'Insta App'
    end

    it 'topページのリンクを確認' do
      expect(page).to have_link href: root_path
    end
  end

  describe 'Help' do
    it 'helpページでのタイトルの表示' do
      visit help_path
      expect(page).to have_title 'Help | Insta App'
    end
  end
end

