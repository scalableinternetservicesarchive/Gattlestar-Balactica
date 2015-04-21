class Course < ActiveRecord::Base
	def self.search_by_dept(dept)
		Course.where(department: dept)
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
			test_documents << Document.search_test(test_id)
		end
		test_documents
	end
end