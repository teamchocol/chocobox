class ApplicationMailer < ActionMailer::Base
  default  from: 'chocobox管理者',
           bcc: "chocoboxchocobox@gmail.com",
           reply_to: "chocoboxchocobox@gmail.com"
  layout 'mailer'
end
