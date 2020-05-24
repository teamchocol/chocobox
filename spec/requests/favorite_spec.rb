require 'rails_helper'

describe 'いいね登録機能' do
  let!(:user) { FactoryBot.create(:user) }

  context 'いいね登録していない場合' do
    it 'いいね登録できる' do
      login_as(user, :scope => :user)
      visit chocolates_path
      expect do
        find('#far').click
      end .to change { Favorite.count }.by(+1)
      expect(page).to have_no_css ''
    end
  end

  context 'お気に入り登録している場合' do
    before do
      login_as(user, :scope => :user)
      visit chocolates_path
      expect do
        find('#far').click
      end
    end

    it 'いいね登録を解除できる' do
      expect do
        find('#fas').click
      end .to change { Favorite.count }.by(-1)
      expect(page).to have_content ''
    end
  end
end
