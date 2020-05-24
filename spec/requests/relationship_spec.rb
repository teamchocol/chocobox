require 'rails_helper'

describe 'ユーザーフォロー機能', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:relationship) { FactoryBot.create(:relationship, followed_id: user.id, follower_id: other_user.id)}
  context '他のユーザーをフォローしていない場合' do
    it 'フォローできること' do
      login_as(user, :scope => :user)
      visit user_path(other_user)
      expect do
        click_on 'フォローする'
      end.to change(Relationship, :count).by(1)
      expect(page).to have_content 'フォローを外す'
    end

  end

  context '他のユーザーをフォローしている場合' do

    it 'ユーザーのフォロー状況が表示されていること' do
      login_as(user, :scope => :user)
      visit follows_users_path(user)
      expect(page).to have_content('フォロー')
      expect(page).to have_content('name')
      expect(page).to have_content('image')
      expect(page).to have_content other_user.name
      #expect(page).to have_content "プロフィール"
    end

    it 'ユーザーのフォロー状況が表示されていること' do
      login_as(user, :scope => :user)
      visit followers_users_path(other_user)
      expect(page).to have_content user.name
    end

    it 'フォロー解除できること' do
      login_as(user, :scope => :user)
      visit user_path(other_user)
      expect do
        click_on 'フォローを外す'
      end.to change(Relationship, :count).by(-1)
      expect(page).to have_content 'フォローする'
    end
  end
end
