class AddDocumentTable < ActiveRecord::Migration
  def change
  	create_table(:documents) do |t|
  		t.string :path
  		t.string :uploader_id
  		t.string :type
  		t.string :quarter_year

  		t.timestamps null: false
  	end
  end
end
