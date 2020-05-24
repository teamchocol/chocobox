require 'rails_helper'

describe 'ユーザー権限のテスト'  do
  let!(:user) { build(:user) }
  describe 'ログインしていない場合' do
    context '投稿関連のURLにアクセス' do
      it 'いいねランキング画面に遷移できない' do
        visit favorite_ranking_chocolates_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'チョコサーチ画面に遷移できない' do
        visit search_chocolates_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'おいしさランキング画面に遷移できない' do
        visit taste_ranking_chocolates_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '健康ランキング画面に遷移できない' do
        visit healthy_ranking_chocolates_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'コスパランキング画面に遷移できない' do
        visit cost_performance_ranking_chocolates_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'コメント一覧画面に遷移できない' do
        visit comments_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '楽天市場人気チョコレート画面に遷移できない' do
        visit chocolates_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザー一覧画面に遷移でない' do
        visit users_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end