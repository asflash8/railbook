# coding: utf-8
require 'test_helper'

class BooksControllerTest < ActionController::TestCase
		test "diff check" do
			assert_difference 'Book.count', 1 do
				post :create, :book => {
					:isbn => '978-4-7741-4223-0',
					:title => 'Rubyポケットリファレンス',
					:price => 3000,
					:publish => '技術評論社',
					:published => '2011-01-01'
				}
			end
		end

#	test "create book is success" do
#		post :create, :book => {
#			:isbn => '978-7741-4223-1',
#			:title => 'Rubyポケットリファレンス',
#			:price => 3000,
#			:publish => '技術評論社',
#			:published => '2011-01-01'
#		}
#		assert_response :success
#	end
end
