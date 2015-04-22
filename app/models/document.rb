class Document < ActiveRecord::Base
	ROOTPATH = '~/Desktop'

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
		@file_path = ROOTPATH + path
		# File.open(@file_path)
	end
end