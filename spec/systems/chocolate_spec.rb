# frozen_string_literal: true

require 'rails_helper'

describe 'アイテム登録機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let!(:product) { FactoryBot.create(:product, title: '一般アイテム') }
  let!(:other_product) { FactoryBot.create(:product, title: 'その他のアイテム') }
  let!(:brand) { FactoryBot.create(:brand) }

  describe '検索機能' do
    it 'アイテムを検索し登録できること' do
      sign_in_as user
      VCR.use_cassette('system/api_response') do
        visit new_product_path
        fill_in 'keyword', with: ' チョコレート'
        click_on '検索'
        expect(page).to have_content '口コミ評価'
        expect { click_on '口コミ投稿をする', match: :first }.to change { Product.count }.by(1)
        expect(page).to have_content 'アイテムを登録しました'
      end
    end
  end

  describe '詳細表示機能' do
    it 'ログイン状態に関わらず登録したアイテム詳細画面を確認できること' do
      visit products_path
      click_link product.title
      expect(page).to have_content('楽天市場で詳しく見る')
    end
  end
 
end
