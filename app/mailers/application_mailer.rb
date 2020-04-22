class ApplicationMailer < ActionMailer::Base
  default  from: 'chocobox管理者'
           bcc: "chocobox@gmail.com",
           reply_to: "chocobox@gmail.com"
  layout 'mailer'
end
