class AddIndex < ActiveRecord::Migration
  def change
  	add_index :documents, :course_id
  	add_index :courses, :department
  	add_index :courses, [:department, :course_id]
  end
end
