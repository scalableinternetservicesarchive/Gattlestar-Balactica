class Course < ActiveRecord::Base
	def self.search_by_dept(dept)
      Course.where('department LIKE ?', dept)
	end

	def self.search_by_course(dept, course_id)
	end
end
