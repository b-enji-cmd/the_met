require './lib/exhibit'
require "minitest/autorun"
require "pry"

class ExhibitTest < Minitest::Test 
	def setup
		@exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})
	end

	def test_it_is
		assert_instance_of Exhibit, @exhibit
	end
end