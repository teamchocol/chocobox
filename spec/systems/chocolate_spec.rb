# frozen_string_literal: true

require 'rails_helper'

describe '商品口コミ登録機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'チョコサーチで検索' do
    it 'チョコレートを検索し口コミ登録できること' do
      sign_in_as user
      visit search_chocolates_path
      fill_in 'keyword', with: ' チョコレート'
      click_on '検索'
      expect(page).to have_content '商品に口コミを投稿する'
      expect { click_on '商品に口コミ投稿をする', match: :first }
      expect(page).to have_content '商品詳細画面'  
    end
  end

  describe '詳細表示機能' do
    it '商品詳細画面を確認できること' do
      sign_in_as user
      visit chocolates_path
      click_link '商品に口コミ投稿をする'
      expect(page).to have_content('楽天市場で見る')
    end
  end
 
end
