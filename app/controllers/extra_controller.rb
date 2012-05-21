# coding: utf-8
class ExtraController < ApplicationController
	def sendmail
		user = User.find(6)
		@mail = NoticeMailer.sendmail_confirm(user).deliver
		render :text => 'メールが正しく送信できました。'
	end
end
