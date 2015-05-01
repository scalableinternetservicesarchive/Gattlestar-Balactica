class RemoveDescription < ActiveRecord::Migration
  def change
    remove_column :documents, :description
  end
end
