# coding: utf-8

class HelloController < ApplicationController
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

end
