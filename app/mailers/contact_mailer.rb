class ContactMailer < ApplicationMailer
  def creation_email(contact)
    @contact = contact
    mail(
      subject: 'ChoCoBoXへのお問い合わせありがとうございます。',
      to: contact.email,
      bcc: 'chocoboxchocobox@gmail.com',
      # NOTE: from に環境変数を設定するとdevやtest環境で設定していない場合
      #      既定のアドレスを設定している
      from: 'chocoboxchocobox@gmail.com'
    )
  end

  def send_when_admin_reply(user, contact) # メソッドに対して引数を設定
    @user = user # ユーザー情報
    @answer = contact.reply_text # 返信内容
    mail to: user.email, subject: '【サイト名】 お問い合わせありがとうございます'
  end
end
