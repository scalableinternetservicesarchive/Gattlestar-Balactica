class AddCoursesCreditsDocumentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :courses_taken, :string
    add_column :users, :documents_uploaded, :string
    add_column :users, :credits, :integer, default:0
  end
end
