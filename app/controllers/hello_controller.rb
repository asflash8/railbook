# coding: utf-8
class HelloController < ApplicationController
	before_filter :check_logined, :only => ['view']

  def list
		@books = Book.all
  end

  def index
		render :text => 'こんにちは、世界！'
  end

  def view
		@msg = 'こんにちは、世界！'
  end

	def app_var
		render :text => Railbook::Application.config.author
	end

	private
	def check_logined
		if session[:usr] then
			begin
				@usr = User.find(session[:usr])
			rescue ActiveRecord::RecordNotFound
				reset_session
			end
		end

		unless @usr
			flash[:referer] = request.fullpath
			redirect_to :controller => 'login', :action => 'index'
		end
	end
end
