class CreatePlotToFamilies < ActiveRecord::Migration
  def change
    create_table :plot_to_families do |t|
      t.integer :plot_id
      t.integer :plot_family_id

      t.timestamps null: false
    end
  end
end
