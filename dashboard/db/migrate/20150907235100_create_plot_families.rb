class CreatePlotFamilies < ActiveRecord::Migration
  def change
    create_table :plot_families do |t|
      t.string :name
      t.integer :refresh_int_mins

      t.timestamps null: false
    end
  end
end
