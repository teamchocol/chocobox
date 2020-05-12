require 'rails_helper'

RSpec.describe Mailer, type: :model do
  let(:contact) do
    create(:contact,
           name: 'TestUser',
           email: 'test@chocobox.jp',
           title: 'テストタイトル',
           content: 'テストコンテント')
  end
  let(:mail) { ContactMailer.creation_email(contact) }

  describe '#creation_email' do
    it 'Subject 定型文になること' do
      expect(mail.subject).to eq 'SuppleBoxへのお問い合わせありがとうございます。'
    end

    it 'To が問い合わせした人のメールアドレスになること' do
      expect(mail.to).to eq ['test@supplebox.jp']
    end

    it 'From が管理用メールアドレスになること' do
      expect(mail.from).to eq ['suppleboxmanager@gmail.com']
    end

    it 'BCC が管理用メールアドレスになること' do
      expect(mail.bcc).to eq ['suppleboxmanager@gmail.com']
    end

    it 'Body に問い合わせた人の名前が含まれること' do
      expect(mail.body).to include 'TestUser さま、'
    end

    it 'Body に問い合わせたタイトルが含まれること' do
      expect(mail.body).to include 'テストタイトル'
    end

    it 'Body に問い合わせた内容が含まれること' do
      expect(mail.body).to include 'テストコンテント'
    end
  end
end
