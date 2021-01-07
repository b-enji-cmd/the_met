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
end