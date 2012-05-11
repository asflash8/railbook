# coding: utf-8
class ViewController < ApplicationController
	def form_tag
		@book = Book.new
	end
	
	def fields
		@user = User.find(1)
	end
end
