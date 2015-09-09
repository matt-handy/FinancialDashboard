class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.string :name
      t.integer :days_duration

      t.timestamps null: false
    end
  end
end
