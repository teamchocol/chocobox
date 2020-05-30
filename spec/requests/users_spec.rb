require 'rails_helper'

describe 'ユーザー認証のテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_registration_path
  end

  describe 'ユーザー新規登録' do
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[nickname]', with: 'テストユーザー'
        fill_in 'user[email]', with: Faker::Internet.email
        select '女性', from: 'user_gender'
        select '10代', from: 'user_age'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録'

        expect(page).to have_content 'アカウント登録が完了しました'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録'

        expect(page).to have_content 'エラー'
        expect(page).to have_content '保存されません'
      end
    end
  end

  describe 'ユーザーログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context 'ログイン画面に遷移' do
      let(:test_user) { user }

      it 'ログインに成功する' do
        visit new_user_session_path
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_on 'ログインする'

        expect(page).to have_content 'ログインしました'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'ユーザーのテスト' do
    let(:user) { create(:user) }
    let!(:test_user2) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end

    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end

      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_user_path(test_user2)
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end

      context '表示の確認' do
        before do
          visit edit_user_path(user)
        end

        it '名前編集フォームに自分の名前が表示される' do
          expect(page).to have_field 'user[name]', with: user.name
        end
        it '名前編集フォームに自分のニックネームが表示される' do
          expect(page).to have_field 'user[nickname]', with: user.nickname
        end
        it '画像編集フォームが表示される' do
          expect(page).to have_field 'user[profile_image]'
        end
        it '自己紹介編集フォームに自分の自己紹介が表示される' do
          expect(page).to have_field 'user[introduction]', with: user.introduction
        end
        it '自己紹介編集フォームに自分の性別が表示される' do
          expect(page).to have_selector '#user-gender'
        end
        it '自己紹介編集フォームに自分の年齢が表示される' do
          expect(page).to have_selector '#user-age'
        end
        it '編集に成功する' do
          click_button '保存'
          expect(page).to have_content 'successfully'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
        it '編集に失敗する' do
          fill_in 'user[name]', with: ''
          click_button '保存'
          expect(page).to have_content 'エラー'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end
    end

    describe '一覧画面のテスト' do
      before do
        visit users_path
      end

      context '表示の確認' do
        it 'ユーザーと表示される' do
          expect(page).to have_content('ユーザー')
        end
        it '自分と他の人の名前が表示される' do
          expect(page).to have_content user.nickname
          expect(page).to have_content test_user2.nickname
        end
        it 'showリンクが表示される' do
          expect(page).to have_link 'プロフィールを見る', href: user_path(user)
          expect(page).to have_link 'プロフィールを見る', href: user_path(test_user2)
        end
      end
    end
  end
end
