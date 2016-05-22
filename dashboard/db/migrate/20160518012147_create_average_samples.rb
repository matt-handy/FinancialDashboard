class CreateAverageSamples < ActiveRecord::Migration
  def change
    create_table :average_samples do |t|
      t.integer :moving_average_id
      t.float :value
      t.date :stamp
      t.integer :indicator_id

      t.timestamps null: false
    end
  end
end
