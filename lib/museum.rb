class Museum
	attr_reader :name,
				:exhibits,
				:patrons
	def initialize(name)
		@name = name
		@exhibits = []
		@patrons = []
	end
	
	def add_exhibit(exhibit)
		@exhibits << exhibit
	end

	def admit(patron)
		@patrons << patron
	end

	def recommend_exhibits(patron)
		@exhibits.find_all do |exhibit|
			patron.interests.include? exhibit.name
		end
	end

	def patrons_by_exhibit_interest
		breakdown = Hash.new

		@exhibits.each do |exhibit|
			@patrons.each do |patron|
				breakdown[exhibit] ||= []
				breakdown[exhibit] << patron unless !patron.interests.include? exhibit.name
			end			
		end
		breakdown
	end

	def ticket_lottery_contestants(exhibit)
		@patrons.find_all do |patron|
			patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
		end
	end

end