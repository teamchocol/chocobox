require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    within 'header' do
      expect(page).to have_link(' ホーム画面', href: '/home')
      expect(page).to have_link('このサイトについて', href: '/about')
      expect(page).to have_link('新規登録', href: '/sign_up')
      expect(page).to have_link('ログイン', href: '/sign_in')
      expect(page).to have_link('ゲストログイン', href: 'users/guest_sign_in')
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }
    before do
      login_as(user, :scope => :user)
    end
    within 'header' do
      expect(page).to have_link('チョコレート登録', href: '/chocolates/search')
      expect(page).to have_link('マイページ', href: '/users/')
      expect(page).to have_link('「ユーザー」一覧', href: '/users')
      expect(page).to have_link('楽天市場人気チョコレート', href: '/chocolates')
      expect(page).to have_link('「口コミ」一覧', href: '/comments')
      expect(page).to have_link('「いいねランキング」一覧', href: '/chocolates/favorite_ranking')
      expect(page).to have_link('「おいしさランキング」一覧', href: '/chocolates/taste_ranking')
      expect(page).to have_link('「健康面ランキング」一覧', href: '/chocolates/cost_performance_ranking')
      expect(page).to have_link('「コスパランキング」一覧', href: '/chocolates/healthy_ranking')
    end
  end
end
