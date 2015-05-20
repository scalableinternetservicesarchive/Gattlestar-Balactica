class AddDocsUploadedTodayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :docs_uploaded_today, :integer, default: 0
  end
end
