require 'rails_helper'

describe '問い合わせ機能', type: :request do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  # it '問い合わせが成功すること' do
  #   login_as(user, :scope => :user)
  #   visit contacts_path
  #   perform_enqueued_jobs do
  #     expect do
  #       fill_in 'お名前', with: 'テストユーザー'
  #       fill_in 'メールアドレス', with: 'test@chocobox.jp'
  #       fill_in 'タイトル', with: 'テストタイトル'
  #       fill_in 'お問い合わせ内容', with: 'テストコンテント'
  #       click_on '送信する'
  #     end.to change(Contact, :count).by(1)
  #     expect(page).to have_content 'お問い合わせを送信しました'
  #   end
  #   mail = ActionMailer::Base.deliveries.last

  #   expect(mail.to).to eq ['test@chocobox.jp']
  #   expect(mail.body).to include 'テストタイトル'
  # end

  it 'お問い合わせが失敗すること' do
    login_as(user, :scope => :user)
    visit contacts_path
    expect { click_on '送信する' }.to change(Contact, :count).by(0)
    expect(page).to have_content 'お問い合わせの送信に失敗しました'
  end
end
