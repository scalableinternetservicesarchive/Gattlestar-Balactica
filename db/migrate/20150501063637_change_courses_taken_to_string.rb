class ChangeCoursesTakenToString < ActiveRecord::Migration
  def change
    change_column :users, :courses_taken, :string, :null => false, :default => ""
  end
end
