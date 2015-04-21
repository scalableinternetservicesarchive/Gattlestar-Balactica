class Document < ActiveRecord::Base
	def self.search_test(test_id)
		Document.where(id: test_id)
	end

	def format_quarter_year
		quarter_year.sub(/\_/,' ')
	end
end