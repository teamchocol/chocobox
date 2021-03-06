require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  let!(:user) { create(:user) }
  let!(:comment) { create(:comment, user_id: user.id) }

  describe 'バリデーションのテスト' do
    context 'titleカラム' do
      it '空欄でないこと' do
        comment.title = ''
        expect(comment.valid?).to eq false
      end
      it 'タイトルが50文字超だと無効な状態であること' do
        comment.title = 'a' * 51
        comment.valid?
        expect(comment.errors[:title]).to include('は50文字以内で入力してください')
      end
    end
  end

  describe 'おいしさ評価を検証する場合' do
    it 'おいしさ評価がないと無効な状態であること' do
      comment.taste = nil
      comment.valid?
      expect(comment.errors[:taste]).to include('は数値で入力してください')
    end

    it 'おいしさ評価が0.5未満だと無効な状態であること' do
      comment.taste = -1
      comment.valid?
      expect(comment.errors[:taste]).to include('は0.5以上の値にしてください')
    end

    it 'おいしさ評価が1.0だと有効な状態であること' do
      comment.taste = 1.0
      comment.valid?
      expect(comment).to be_valid
    end

    it 'おいしさ評価が5.0だと有効な状態であること' do
      comment.taste = 5.0
      comment.valid?
      expect(comment).to be_valid
    end

    it 'おいしさ評価が5超だと無効な状態であること' do
      comment.taste = 6
      comment.valid?
      expect(comment.errors[:taste]).to include('は5以下の値にしてください')
    end
  end

  describe '健康評価を検証する場合' do
    it '健康評価がないと無効な状態であること' do
      comment.healthy = nil
      comment.valid?
      expect(comment.errors[:healthy]).to include('は数値で入力してください')
    end

    it '健康評価が0.5未満だと無効な状態であること' do
      comment.healthy = -1
      comment.valid?
      expect(comment.errors[:healthy]).to include('は0.5以上の値にしてください')
    end

    it '健康評価が1.0だと有効な状態であること' do
      comment.healthy = 1.0
      comment.valid?
      expect(comment).to be_valid
    end

    it '健康評価が5.0だと有効な状態であること' do
      comment.healthy = 5.0
      comment.valid?
      expect(comment).to be_valid
    end

    it '健康評価が5超だと無効な状態であること' do
      comment.healthy = 6
      comment.valid?
      expect(comment.errors[:healthy]).to include('は5以下の値にしてください')
    end
  end

  describe 'コスパ評価を検証する場合' do
    it 'コスパ評価がないと無効な状態であること' do
      comment.cost_performance = nil
      comment.valid?
      expect(comment.errors[:cost_performance]).to include('は数値で入力してください')
    end

    it 'コスパ評価が0.5未満だと無効な状態であること' do
      comment.cost_performance = -1
      comment.valid?
      expect(comment.errors[:cost_performance]).to include('は0.5以上の値にしてください')
    end

    it 'コスパ評価が1.0だと有効な状態であること' do
      comment.cost_performance = 1.0
      comment.valid?
      expect(comment).to be_valid
    end

    it 'コスパ評価が5.0だと有効な状態であること' do
      comment.cost_performance = 5.0
      comment.valid?
      expect(comment).to be_valid
    end

    it 'コスパ評価が5超だと無効な状態であること' do
      comment.cost_performance = 6
      comment.valid?
      expect(comment.errors[:cost_performance]).to include('は5以下の値にしてください')
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
