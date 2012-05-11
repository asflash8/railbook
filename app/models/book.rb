# coding: utf-8
class Book < ActiveRecord::Base
	has_many :reviews
	has_and_belongs_to_many :authors
	has_many :users, :through => :reviews
	validates :isbn,
		:presence => true,
		:uniqueness => true,
		:length => { :is => 17 },
		:isbn => true
	validates :title,
		:presence => true,
		:length => { :minimum => 1, :maximum => 100 }
	validates :price,
		:numericality => { :only_integer => true, :less_than => 10000 }
	validates :publish,
		:inclusion => { :in => ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'インプレスジャパン'] }
	validate :isbn_valid?
	after_destroy :history_book

	scope :gihyo, where(:publish => '技術評論社')
	scope :newer, order('published DESC')
	scope :top10, newer.limit(10)
	scope :top1, newer.limit(1)
	scope :whats_new, lambda {
		#|pub| where(:publish => pub).order('published DESC').limit(5)
		|pub| where(:publish => pub).newer.top10
	}
	
	private
	def isbn_valid?
		errors.add(:isbn, 'は正しい形式ではありません。') unless isbn =~ /^[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]$/
	end

	def history_book
		logger.info('deleted: ' + self.inspect)
	end
end
