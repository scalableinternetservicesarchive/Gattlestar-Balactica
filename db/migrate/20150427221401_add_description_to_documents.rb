class AddDescriptionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :description, :string, :null => false, :default => ""
  end
end
