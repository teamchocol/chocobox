require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
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
      expect(mail.subject).to eq 'ChoCoBoXへのお問い合わせありがとうございます。'
    end

    it 'To が問い合わせした人のメールアドレスになること' do
      expect(mail.to).to eq ['test@chocobox.jp']
    end

    it 'From が管理用メールアドレスになること' do
      expect(mail.from).to eq ['chocoboxchocobox@gmail.com']
    end

    it 'BCC が管理用メールアドレスになること' do
      expect(mail.bcc).to eq ['chocoboxchocobox@gmail.com']
    end

    it 'Body に問い合わせた人の名前が含まれること' do
      expect(mail.body).to include 'TestUser様、'
    end

    it 'Body に問い合わせたタイトルが含まれること' do
      expect(mail.body).to include 'テストタイトル'
    end

    it 'Body に問い合わせた内容が含まれること' do
      expect(mail.body).to include 'テストコンテント'
    end
  end
end
