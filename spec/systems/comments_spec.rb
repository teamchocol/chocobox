# frozen_string_literal: true

require 'rails_helper'

describe '口コミ投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, nickname: 'その他ユーザー') }
  let!(:comment) { FactoryBot.create(:comment, user: user, content: '一般の口コミ') }
  let!(:other_comment) { FactoryBot.create(:comment, content: 'その他の口コミ') }

  describe '新規作成機能' do
    
    it '口コミ投稿できる場合' do
      sign_in_as user
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
      end.to change { comment.count }.by(+1)
      expect(page).to have_content '口コミを投稿しました'
    end
  end

  describe '一覧表示機能' do
    before do
      sign_in_as user
    end

    it '口コミ一覧に表示されること' do
      visit comments_path
      expect(page).to have_content 'テストタイトル' # トップページの口コミ
    end
    it '口コミ一覧に表示されること' do
      visit comments_path
      expect(page).to have_content 'みんなの口コミを見てみよう！' # トップページの口コミ
    end
  end

  describe '一覧検索機能' do
    context '一致する口コミが存在する場合' do
      it '口コミが表示されること' do
        visit posts_path
        fill_in 'q_title_or_content_or_product_title_cont', with: comment.content
        click_on '口コミを検索'
        expect(page).to have_content comment.content
        expect(page).to_not have_content other_comment.content
      end
    end

    context '一致する口コミが存在しない場合' do
      it '口コミが表示されないこと' do
        visit comments_path
        fill_in 'q_title_or_content_or_product_title_cont', with: '架空の口コミ'
        click_on '口コミを検索'
        expect(page).to_not have_content comment.content
        expect(page).to_not have_content other_post.content
      end
    end
  end
end
