# coding: utf-8
class RecordController < ApplicationController

	def find
		@books = Book.find([2, 5, 10])
		render 'hello/list'
	end

	def dynamic_find
		@books = Book.find_all_by_publish('技術評論社')
		render 'hello/list'
	end

	def dynamic_find2
		@books = Book.find_all_by_publish_and_price('技術評論社', 2604)
		render 'hello/list'
	end
	
	def where
		@books = Book.where(:publish => '技術評論社')
		render 'hello/list'
	end

	def ph1 
		@books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
		render 'hello/list'
	end

	def select 
		@books = Book.where('price >= 2000').select('title, price, isbn, publish, published, cd').order('price DESC')
		render 'hello/list'
	end

	def offset
		@books = Book.order('price DESC').limit(3).offset(4)
		render 'hello/list'
	end

	def last
		@book = Book.order('published DESC').limit(3).last
		render 'books/show'
	end

	def first
		@book = Book.order('published DESC').limit(3).first
		render 'books/show'
	end

	def groupby
		@books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
	end

	def havingby
		@books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having(['AVG(price) >= ?', 3000])
		render 'record/groupby'
	end

	def exists
		flag = Book.where(:publish => '技術評論社').exists?(['price > ?', 3000])
		render :text => "存在するか？　：　#{flag}"
	end

	def scope
		@books = Book.gihyo.top10
		render 'hello/list'
	end

	def lambda_scope
		@books = Book.whats_new('技術評論社')
		render 'hello/list'
	end

	def def_scope
		render :text => Review.all.inspect
	end

	def count
		cnt = Book.where(:publish => '技術評論社').count
		render :text => "#{cnt}件です。"
	end

	def average
		price = Book.where(:publish => '技術評論社').average('price')
		render :text => "平均価格は#{price}円です。"
	end

	def literal_sql
		@books = Book.find_by_sql(['SELECT publish, AVG(price) AS avg_price FROM "books" GROUP BY publish HAVING AVG(price) >= ?', 2500])
		render 'record/groupby'
	end

	def protect_attr
		@user = User.new({
			:username => 'tyamada',
			:password => '12345',
			:email => 'tyamada@wings.msn.to',
			:dm => false,
			:roles => 'admin'
		})
		render :text => "ロール情報　:　#{@user.roles}"
	end

	def update_all
		cnt = Book.update_all('price = price / 2', ['publish = ?', '技術評論社'])
		render :text => "#{cnt}件のデータを更新しました。"
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
	end

	def transact
		Book.transaction do
			b1 = Book.new({
				:isbn=> '978-4-7741-4223-0',
				:title => 'Rubyポケットリファレンス',
				:price => 2000,
				:publish => '技術評論社',
				:published => '2011-02-01'
			})
			b1.save!
			raise '例外発生：処理はキャンセルされました。'
			b2 = Book.new({
				:isbn=> '978-4-7741-4223-2',
				:title => 'Tomcatポケットリファレンス',
				:price => 2500,
				:publish => '技術評論社',
				:published => '2011-03-01'
			})
			b2.save!
		end
		render :text => 'トランザクションは成功しました。'
	rescue => e
		render :text => e.message
	end

	def belongs
		@review = Review.find(3)
	end

	def hasmany
		@book = Book.where(:isbn => '978-4-7741-4466-5').first
	end

	def hasone
		@user = User.where(:username => 'yyamada').first
	end

	def has_and_belongs
		@book = Book.where(:isbn => '978-4-7741-4466-5').first
	end

	def has_many_through
		@user = User.where(:username => 'isatou').first
	end
end
