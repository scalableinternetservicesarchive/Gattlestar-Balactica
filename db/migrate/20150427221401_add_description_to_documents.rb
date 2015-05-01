class AddDescriptionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :description
	end
end
