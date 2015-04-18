class Course < ActiveRecord::Base
	def self.search_by_dept(dept)
		Course.find_by department: dept
	end

	def self.search_by_course(dept, course_id)
	end
end