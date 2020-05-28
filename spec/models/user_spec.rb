require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  let!(:user) { build(:user) }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    context 'nameカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '1文字以上であること' do
        test_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '空欄でないこと' do
        test_user.nickname = ''
        is_expected.to eq false
      end
      it '1文字以上であること' do
        test_user.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること' do
        test_user.nickname = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    describe 'メールアドレスを検証する場合' do
      it 'メールアドレスが無いと無効な状態であること' do
        user.email = nil
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end

      it '重複したメールアドレスなら無効な状態であること' do
        FactoryBot.create(:user, email: 'tester@supplebox.jp')
        user.email = 'tester@supplebox.jp'
        user.valid?
        expect(user.errors[:email]).to include('はすでに存在します')
      end

      it 'メールアドレスに@が含まれていないなら無効な状態であること' do
        user.email = 'supplebox.jp'
        user.valid?
        expect(user.errors[:email]).to include('は不正な値です')
      end

      it 'メールアドレスが保存される前に小文字に変換されること' do
        user.email = 'TESTADD@supplebox.jp'
        user.save
        expect(user.email).to eq 'testadd@supplebox.jp'
      end
    end

    describe 'パスワードを検証する場合' do
      it 'パスワードと確認用パスワードが一致していないと無効な状態であること' do
        user.password = 'password'
        user.password_confirmation = 'invalid_password'
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end

      it 'パスワードが6文字未満なら無効な状態であること' do
        user.password = user.password_confirmation = 'a' * 5
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }

      it '100文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end

  describe '自己紹介を検証する場合' do
    let(:test_user) { user }
    it '100文字超だと無効な状態であること' do
      test_user.introduction = Faker::Lorem.characters(number: 101)
      test_user.valid?
      expect(user.errors[:introduction]).to include('は100文字以内で入力してください')
    end
  end

  describe 'follow/unfollow/following?メソッドを検証する場合' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context 'followしていない状態の場合' do
      it '無効な状態であること' do
        expect(user.following?(another_user)).to eq false
      end
    end

    context 'followした場合' do
      before do
        user.follow(another_user.id)
      end

      it 'follow状態になること' do
        expect(user.following?(another_user)).to eq true
      end

      it 'unfollowすると無効な状態であること' do
        user.unfollow(another_user.id)
        expect(user.following?(another_user)).to eq false
      end
    end
  end

  describe 'create/destroy/favorited_by?(iメソッドを検証する場合' do
    sample_item_code = 'test:0000'
    context 'favorited_byしていない状態の場合' do
      it '無効な状態であること' do
        expect(user.favorited_by?(sample_item_code)).to eq nil
      end
    end

    context 'createした場合' do
      let(:favorite) { create(:favorite, user_id: user.id, item_code: sample_item_code) }

      it 'favorited_by状態であること' do
        expect(user.favorited_by?(favorite.item_code)).to eq favorite
      end

      it 'お気に入りしていないアイテムが無効な状態であること' do
        sample_item_code2 = 'test:0001'
        expect(user.favorited_by?(sample_item_code2)).to eq nil
        expect(another_user.favorited_by?(sample_item_code)).to eq nil
        expect(another_user.favorited_by?(sample_item_code2)).to eq nil
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Contactモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end
