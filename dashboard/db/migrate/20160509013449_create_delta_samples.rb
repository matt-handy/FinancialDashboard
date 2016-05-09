class CreateDeltaSamples < ActiveRecord::Migration
  def change
    create_table :delta_samples do |t|
      t.float :value
      t.references :indicators, index: true, foreign_key: true
      t.references :price_delta_categories, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
