require 'rails_helper'

describe '商品口コミ登録機能', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe 'チョコサーチで検索' do
    it 'チョコレートを検索し口コミ登録できること' do
      login_as(user, :scope => :user)
      visit search_chocolates_path
      fill_in 'keyword', with: 'チョコレート'
      click_on '検索'
      expect(page).to have_content '商品に口コミを投稿する'
    end
  end

  describe '詳細表示機能' do 
    it 'チョコレートを検索し口コミ登録できること' do
      login_as(user, :scope => :user)     
      visit ranking_chocolates_path(range: 3)
      # ランキング上位の商品は在庫切れになりやすく商品詳細情報がとって来れない可能性があるためランキング下位の商品ページに設定している 
      click_on '口コミを投稿する', match: :first
      expect(page).to have_content '商品 詳細画面'  
    end
  end
end
