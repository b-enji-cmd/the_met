require './lib/exhibit'
require './lib/patron'
require "minitest/autorun"
require "pry"

class PatronTest < Minitest::Test
	def setup
		@exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})
		@patron_1 = Patron.new("Bob", 20)
	end

	def test_it_is
		assert_instance_of Patron, @patron_1
	end

	def test_it_has_things
		assert_equal "Bob", @patron_1.name
		assert_equal 20, @patron_1.spending_money
	end

	def test_it_can_have_interests
		assert_equal [], @patron_1.interests
	end

	def test_it_can_add_interests
		@patron_1.add_interest("Dead Sea Scrolls")
		@patron_1.add_interest("Gems and Minerals")
		assert_equal ["Dead Sea Scrolls","Gems and Minerals"], @patron_1.interests
	end
end