class AddFieldsToDocuments < ActiveRecord::Migration
  def change
    rename_column :documents, :quarter_year, :quarter
    add_column :documents, :year, :string, :null => false, :default => ""
    add_column :documents, :course_id, :string, :null => false, :default => 1
  end
end
