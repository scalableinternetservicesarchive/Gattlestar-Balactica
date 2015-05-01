class ChangeCoursesTakenInUsers < ActiveRecord::Migration
  def change
  	change_column(:users, "courses_taken", :text)
  end
end
