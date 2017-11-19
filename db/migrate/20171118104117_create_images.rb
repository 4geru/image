class CreateImages < ActiveRecord::Migration[5.1]
  def change
  	create_table :images do |t|
		t.string :file_name
	end
  end
end
