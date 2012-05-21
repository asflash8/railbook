# coding: utf-8
class CtrlController < ApplicationController
	require 'kconv'

	before_filter :start_logger
	after_filter :end_logger
	around_filter :around_logger
	before_filter :auth, :only => 'updb'

	def req_headers
		@headers = request.headers
	end
	
	def upload_process
		file = params[:upfile]
		name = file.original_filename
		perms = ['.jpg', '.jpeg', '.gif', '.png']
		if !perms.include?(File.extname(name).downcase)
			result = 'アップロードできるのは画像ファイルのみです。'
		elsif file.size > 1.megabyte
			result = 'ファイルサイズは1MBまでです。'
		else
			name = name.kconv(Kconv::SJIS, Kconv::UTF8)
			File.open("public/docs/#{name}", 'wb') {|f| f.write(file.read)}
			result = "#{name.toutf8}をアップロードしました。"
		end

		render :text => result
	end

	def updb
		@author = Author.find(params[:id])
	end

	def updb_process
		@author = Author.find(params[:id])
		if @author.update_attributes(params[:author])
			render :text => '保存に成功しました'
		else
			render :text => @author.errors.full_messages[0]
		end
	end

	def get_xml
		@books = Book.all
		render :xml => @books
	end

	def get_json
		@books = Book.all
		render :json => @books
	end

	private
	def start_logger
		logger.debug('[Start] ' + Time.now.to_s)
	end

	def end_logger
		logger.debug('[Finish] ' + Time.now.to_s)
	end

	def around_logger
		logger.debug('[Start_around] ' + Time.now.to_s)
		yield
		logger.debug('[Finish_around] ' + Time.now.to_s)
	end

	def auth
		name = 'yyamada'
		passwd = '8cb2237d0679ca88db6464eac60da96345513964'
		authenticate_or_request_with_http_basic('Railbook') do |n, p|
			n == name && passwd == Digest::SHA1.hexdigest(p)
		end
	end
end
