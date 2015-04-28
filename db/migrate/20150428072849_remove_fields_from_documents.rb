class RemoveFieldsFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :doc_type
    remove_column :documents, :path
  end
end
