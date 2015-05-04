class RemoveTestIdFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :test_id, :string
  end
end
