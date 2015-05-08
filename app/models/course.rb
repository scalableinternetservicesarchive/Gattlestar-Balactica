class Course < ActiveRecord::Base
  def self.search_by_dept(dept)
    Course.where('department LIKE ?', dept)
  end

  # return ActiveRecords relation, not an array
  def self.search_by_course(dept, course_id)
    Course.where(department: dept, course_id: course_id)
  end

  def self.search_by_course_and_professor(dept, course_id, last_name, first_name)
    Course.where(department: dept, course_id: course_id, professor_last_name: last_name, professor_first_name: first_name)
  end

  def format_name
    professor_first_name + " " + professor_last_name
  end

	def self.find_all_department
		Course.uniq.pluck(:department)
	end

	def self.find_all_courses
		departments = find_all_department
		course_hash = {}
		departments.each do |dept|
			courses = search_by_dept(dept)
			course_hash[dept] = courses.uniq.pluck(:course_id)
		end
		course_hash
	end
end
