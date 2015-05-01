class AddDescription < ActiveRecord::Migration
  def change
  	add_column :documents, :description, :string, :default => "" 
  end
end
