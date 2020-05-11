require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '1文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
      it '空欄でないこと' do
        test_user.nickname = ''
        is_expected.to eq false;
      end
      it '1文字以上であること' do
        test_user.nickname = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.nickname = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
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
        test_user.introduction = Faker::Lorem.characters(number:101)
        is_expected.to eq false
      end
    end
  end
  
  describe '自己紹介を検証する場合' do
    it '100文字超だと無効な状態であること' do
      user.comment = 'a' * 101
      user.valid?
      expect(user.errors[:comment]).to include('は100文字以内で入力してください')
    end
  end
  
  describe 'follow/unfollow/following?メソッドを検証する場合' do
    context 'followしていない状態の場合' do
      it '無効な状態であること' do
        expect(user.following?(user)).to eq false
      end
    end

    context 'followした場合' do
      before do
        user.follow(user_id)
      end

      it 'follow状態になること' do
        expect(user.followers).to include user
        expect(user.following?(user)).to eq true
      end

      it 'unfollowすると無効な状態であること' do
        user.unfollow(user_id)
        expect(user.following?(user)).to eq false
      end
    end
  end

  describe 'create/destroy/favorited_by?(iメソッドを検証する場合' do
    context 'favorited_byしていない状態の場合' do
      it '無効な状態であること' do
        expect(user.favorited_by?(item_code)).to eq false
      end
    end

    context 'createした場合' do
      before do
        user.create(item_code)
      end

      it 'favorited_by状態であること' do
        expect(user.favorited_by?(item_code)).to eq true
      end

      it 'createしていないアイテムが無効な状態であること' do
        expect(user.favorited_by?(item_code: item_code)).to eq false
        expect(other_user.favorited_by?(item_code: item_code)).to eq false
        expect(other_user.favorited_by?(item_code: item_code)).to eq false
      end

      it 'destroyすると無効な状態であること' do
        user.destroy(item_code)
        expect(user.favorited_by?(item_code: item_code)).to eq false
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
