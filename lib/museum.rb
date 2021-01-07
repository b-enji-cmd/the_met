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

end

# The short answer seems to be: a ||= b means,
# if a is undefined then assign it the value of b, 
#otherwise leave it alone.
=begin

@exhibits.flat_map do |exhibit|
			@patrons.flat_map do |patron|
				breakdown[exhibit] << patron if recommend_exhibits(patron)
			end
		end

=end