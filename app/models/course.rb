class Course < ActiveRecord::Base
	def self.search_by_dept(dept)
      	Course.where('department LIKE ?', dept)
	end

	def self.search_by_course(dept, course_id)
		Course.where(department: dept, course_id: course_id)
	end

	def format_name
		professor_first_name + " " + professor_last_name
	end

	def search_test_id
		test_ids = test_id.split(',')
		test_documents = []
		test_ids.each do |test_id|
			result = Document.search_test(test_id)
			if result.length == 0
				return []
			end
			test_documents << result
		end
		test_documents
	end
end
