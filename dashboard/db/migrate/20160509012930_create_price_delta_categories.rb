class CreatePriceDeltaCategories < ActiveRecord::Migration
  def change
    create_table :price_delta_categories do |t|
      t.integer :length
	  t.integer :delta
      t.string :title

      t.timestamps null: false
    end
  end
end
