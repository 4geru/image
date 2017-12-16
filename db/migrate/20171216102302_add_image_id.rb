class AddImageId < ActiveRecord::Migration[5.1]
  def change
  	add_column :images, :image_id, :integer
  end
end
