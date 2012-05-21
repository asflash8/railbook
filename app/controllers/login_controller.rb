# coding: utf-8
class LoginController < ApplicationController

	def auth
		usr = User.authenticate(params[:username], params[:password])
		if usr then
			session[:usr] = usr.id
			redirect_to params[:referer]
		else
			flash.now[:referer] = params[:referer]
			@error = 'username/password is wrong'
			render 'index'
		end
	end
end
