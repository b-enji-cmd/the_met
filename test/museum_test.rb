require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require "minitest/autorun"
require 'mocha/minitest'
require "pry"

class MuseumTest < Minitest::Test
	def setup
		@dmns = Museum.new("Denver Museum of Nature and Science")
		@gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
		@dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
		@imax = Exhibit.new({name: "IMAX",cost: 15})
		@patron_1 = Patron.new("Bob", 20)
		@patron_2 = Patron.new("Sally", 20)
		@patron_3 = Patron.new("Johnny", 5)
		@patron_3.add_interest("Dead Sea Scrolls")
	end

	def test_it_is
		assert_instance_of Museum, @dmns
	end

	def test_it_has_things
		assert_equal "Denver Museum of Nature and Science", @dmns.name
		assert_equal [], @dmns.exhibits
	end

	def test_it_can_add_exhibits
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)
		assert_equal [@gems_and_minerals,@dead_sea_scrolls,@imax], @dmns.exhibits
	end

	def test_it_can_recommend_exhibits
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)

		@patron_1.add_interest("Dead Sea Scrolls")
		@patron_1.add_interest("Gems and Minerals")
		@patron_2.add_interest("IMAX")

		assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@patron_1)
		assert_equal [@imax], @dmns.recommend_exhibits(@patron_2)
	end

	def test_it_can_order_patrons_by_exhibit
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)



		@patron_1.add_interest("Gems and Minerals")
		@patron_1.add_interest("Dead Sea Scrolls")

		@patron_2.add_interest("Dead Sea Scrolls")

		@patron_3.add_interest("Dead Sea Scrolls")

		@dmns.admit(@patron_1)
		@dmns.admit(@patron_2)
		@dmns.admit(@patron_3)


		actual = {
			@gems_and_minerals => [@patron_1],
			@dead_sea_scrolls => [@patron_1, @patron_2, @patron_3],
			@imax => []
		}
		@dmns.patrons_by_exhibit_interest
		assert_equal actual, @dmns.patrons_by_exhibit_interest
	end

	def test_it_can_admit_patrons
		assert_equal [], @dmns.patrons
		@dmns.admit(@patron_1)
		@dmns.admit(@patron_2)
		@dmns.admit(@patron_3)

		assert_equal [@patron_1, @patron_2, @patron_3], @dmns.patrons
	end

	def test_it_can_lottery_contestants
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)

		patron_1 = Patron.new("Bob", 0)
		patron_2 = Patron.new("Sally", 20)
		patron_3 = Patron.new("Johnny", 5)

		patron_1.add_interest("Gems and Minerals")
		patron_1.add_interest("Dead Sea Scrolls")
		patron_2.add_interest("Dead Sea Scrolls")
		patron_3.add_interest("Dead Sea Scrolls")

		@dmns.admit(patron_1)
		@dmns.admit(patron_2)
		@dmns.admit(patron_3)

		#BOB IS #<Patron:0x00007fb2011455b8...>
		#SALLY IS #<Patron:0x00007fb20227f8b0...>
		#JOHNNY IS #<Patron:0x6666fb20114megan...>
		assert_equal [patron_1, patron_3], @dmns.ticket_lottery_contestants(@dead_sea_scrolls)
	end

	def test_it_can_draw_a_winner
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)

		patron_1 = Patron.new("Bob", 0)
		patron_2 = Patron.new("Sally", 20)
		patron_3 = Patron.new("Johnny", 5)

		patron_1.add_interest("Gems and Minerals")
		patron_1.add_interest("Dead Sea Scrolls")
		patron_2.add_interest("Dead Sea Scrolls")
		patron_3.add_interest("Dead Sea Scrolls")

		@dmns.admit(patron_1)
		@dmns.admit(patron_2)
		@dmns.admit(patron_3)

		@dmns.draw_lottery_winner(@dead_sea_scrolls)
		@dmns.stub(:draw_lottery_winner).returns(patron_1)

	end

	def test_it_can_announce_lottery
		@dmns.add_exhibit(@gems_and_minerals)
		@dmns.add_exhibit(@dead_sea_scrolls)
		@dmns.add_exhibit(@imax)

		patron_1 = Patron.new("Bob", 0)
		patron_2 = Patron.new("Sally", 20)
		patron_3 = Patron.new("Johnny", 5)

		patron_1.add_interest("Gems and Minerals")
		patron_1.add_interest("Dead Sea Scrolls")
		patron_2.add_interest("Dead Sea Scrolls")
		patron_3.add_interest("Dead Sea Scrolls")

		@dmns.admit(patron_1)
		@dmns.admit(patron_2)
		@dmns.admit(patron_3)


	end
end