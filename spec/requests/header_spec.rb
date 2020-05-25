require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'ChocoBox'
      end
      it 'Homeリンクが表示される' do
        home_link = find_all('a')[2].native.inner_text
        expect(home_link).to match("ホーム画面")
        #is_expected.to have_content 'Home'
      end
      it 'Aboutリンクが表示される' do
        about_link = find_all('a')[3].native.inner_text
        expect(about_link).to match("このサイトについて")
        #is_expected.to have_content 'About'
      end
      it 'Sign upリンクが表示される' do
        signup_link = find_all('a')[4].native.inner_text
        expect(signup_link).to match("新規登録")
        #is_expected.to have_content 'Sign up'
      end
      it 'loginリンクが表示される' do
        login_link = find_all('a')[5].native.inner_text
        expect(login_link).to match("ログイン")
        #is_expected.to have_content 'login'
      end 
      it 'ゲストログインリンクが表示される' do
        guest_link = find_all('a')[6].native.inner_text
        expect(guest_link).to match('ゲストログイン')
      end
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }

    before do
      login_as(user, :scope => :user)
      visit root_path
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'ChocoBox'
      end
      it 'チョコレート登録が表示' do
        home_link = find_all('a')[4].native.inner_text
        expect(home_link).to match("あなたの好きなチョコレートを登録する")
        #is_expected.to have_content 'Home'
      end
      it 'マイページの表示' do
        about_link = find_all('a')[5].native.inner_text
        expect(about_link).to match("マイページ")
        #is_expected.to have_content 'About'
      end
      it '「ユーザー」一覧の表示' do
        signup_link = find_all('a')[6].native.inner_text
        expect(signup_link).to match("「ユーザー」一覧")
        #is_expected.to have_content 'Sign up'
      end
      it '楽天市場人気チョコレートの表示' do
        login_link = find_all('a')[7].native.inner_text
        expect(login_link).to match("「楽天市場人気チョコレート」")
        #is_expected.to have_content 'login'
      end 
      it '「口コミ」一覧の表示' do
        guest_link = find_all('a')[8].native.inner_text
        expect(guest_link).to match('「口コミ」一覧')
      end
      it '「いいねランキング」一覧の表示' do
        guest_link = find_all('a')[9].native.inner_text
        expect(guest_link).to match('「いいねランキング」一覧')
      end
      it '「おいしさランキング」一覧の表示' do
        guest_link = find_all('a')[10].native.inner_text
        expect(guest_link).to match('「おいしさランキング」一覧')
      end
      it '「健康面ランキング」一覧' do
        guest_link = find_all('a')[11].native.inner_text
        expect(guest_link).to match('「健康面ランキング」一覧')
      end
      it '「コスパランキング」一覧' do
        guest_link = find_all('a')[12].native.inner_text
        expect(guest_link).to match('「コスパランキング」一覧')
      end
    end
  end
end
