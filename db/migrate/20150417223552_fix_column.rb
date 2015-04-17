class FixColumn < ActiveRecord::Migration
  def change
  	rename_column :documents, :type, :doc_type
  end
end
