class AddCourseTable < ActiveRecord::Migration
  def change
  	create_table(:courses) do |t|
	  	t.string	:department
		t.string	:course_id
		t.string	:professor_last_name
		t.string	:professor_first_name
		t.string	:test_id
		t.string	:homework_id

		t.timestamps	null: false
	end
  end
end
