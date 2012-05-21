# coding: utf-8
class NoticeMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_cofirm.subject
  #
  def sendmail_confirm(user)
		@user = user

    mail :to => user.email, :subject => 'ユーザ登録ありがとうございました'
  end
end
