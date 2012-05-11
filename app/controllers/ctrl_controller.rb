# coding: utf-8
class CtrlController < ApplicationController
	require 'kconv'

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
end
