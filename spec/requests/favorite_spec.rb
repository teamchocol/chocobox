require 'rails_helper'

describe 'いいね登録機能' do
  let!(:user) { FactoryBot.create(:user) }

  context 'いいね登録していない場合', js: true do
    it 'いいね登録できる' do
      login_as(user, :scope => :user)
      visit chocolates_path
      expect do
        find('#far-0').click
      end .to change(Favorite, :count).by(+1)
    end
  end

  context 'お気に入り登録している場合', js: true do
    before do
      login_as(user, :scope => :user)
      visit chocolates_path
      # いいねボタンのリンク先からitem_codeを取得し、事前にfavoriteテーブルにレコードを追加
      create(:favorite, user_id: user.id, item_code: page.find('#far-0')[:href].split('/')[4])
    end

    it 'いいね登録を解除できる' do
      visit chocolates_path
      expect do
        find('#fas-0').click
      end .to change(Favorite, :count).by(-1)
      expect(page).to have_content ''
    end
  end
end
