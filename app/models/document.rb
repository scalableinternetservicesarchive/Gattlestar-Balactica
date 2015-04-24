class Document < ActiveRecord::Base

	def self.search_test(test_id)
		begin
			Document.find(test_id)
		rescue
			# if there is no test_id in the database
			[]
		end
	end

	def format_quarter_year
		quarter_year.sub(/\_/,' ')
	end

	def display_test
		
	end
end