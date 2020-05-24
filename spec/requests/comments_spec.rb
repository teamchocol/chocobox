require 'rails_helper'

describe '口コミ投稿機能', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, nickname: 'その他ユーザー') }
  let!(:comment) { FactoryBot.create(:comment, user: user, content: '一般の口コミ') }
  let!(:other_comment) { FactoryBot.create(:comment, content: 'その他の口コミ') }

  describe '新規作成機能' do
    it '口コミ投稿できる場合' do
      login_as(user, :scope => :user)
      visit chocolates_path
      click_link '商品に口コミ投稿をする'
      expect do
        fill_in 'comment[title]', with: 'テストタイトル'
        find('#taste_review_star', visible: false).set(5.0)
        find('#healthy_review_star', visible: false).set(5.0)
        find('#cost_performance_review_star', visible: false).set(5.0)
        fill_in 'comment[content]', with: 'テストコンテント'
        attach_file 'comment[image]', 'spec/images/test_normal_image.jpg'
        click_on '投稿する'
      end.to change(comment, :count).by(+1)
      expect(page).to have_content '口コミを投稿しました'
    end
  end

  describe '一覧表示機能' do
    it '口コミ一覧に表示されること' do
      login_as(user, :scope => :user)
      visit comments_path
      expect(page).to have_content 'テストタイトル' # 口コミ一覧
    end
  end
end
