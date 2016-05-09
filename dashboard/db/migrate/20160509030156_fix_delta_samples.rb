class FixDeltaSamples < ActiveRecord::Migration
  def change
    remove_column :delta_samples, :indicators_id
	remove_column :delta_samples, :price_delta_categories_id
	
	add_column :delta_samples, :indicator_id, :integer
	add_column :delta_samples, :price_delta_category_id, :integer
  end
end
