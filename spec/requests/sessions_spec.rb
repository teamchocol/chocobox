# frozen_string_literal: true

require 'rails_helper'

describe 'セッション管理機能', type: :request do
  let!(:user) do
    create(:user,
           email: 'test@chocobox.jp',
           password: 'password')
  end

  it '登録済みユーザーがログインとログアウトできること' do
    visit login_path
    fill_in 'メールアドレス', with: 'test@chocobox.jp'
    fill_in 'パスワード', with: 'password'
    within '.login' do
      click_on 'ログイン'
    end
    expect(page).to have_content 'ログインに成功しました。'
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end

  it '登録済みでないユーザーがログインできないこと' do
    visit login_path
    fill_in 'メールアドレス', with: 'test@chocobox.jp'
    fill_in 'パスワード', with: 'dummy_password'
    within '.login' do
      click_on 'ログイン'
    end
    expect(page).to have_content 'ログインに失敗しました。'
  end
end
