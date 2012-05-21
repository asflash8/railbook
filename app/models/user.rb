class User < ActiveRecord::Base
	has_one :author
	has_many :reviews
	has_many :books, :through => :reviews

	attr_protected :roles

	validates :agreement, :acceptance => { :on => :create }
	validates :email, :confirmation => true

	def self.authenticate(username, password)
		where(:username => username, :password => Digest::SHA1.hexdigest(password)).first
	end
end
