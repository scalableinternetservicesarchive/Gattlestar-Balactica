class RemoveHomeworkIdFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :homework_id, :string
  end
end
