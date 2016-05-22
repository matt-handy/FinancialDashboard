class CreateMovingAverages < ActiveRecord::Migration
  def change
    create_table :moving_averages do |t|
      t.string :type
      t.integer :period

      t.timestamps null: false
    end
  end
end
