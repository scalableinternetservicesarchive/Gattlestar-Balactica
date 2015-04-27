class ChangeDescriptionInDocuments < ActiveRecord::Migration
  def change
    change_column :documents, :description, :text
  end
end
