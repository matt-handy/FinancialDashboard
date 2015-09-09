class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :plot_id
      t.integer :indicator_id

      t.timestamps null: false
    end
  end
end
