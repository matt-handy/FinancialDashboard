class FixMovingAverage < ActiveRecord::Migration
  def change
    remove_column :moving_averages, :type
	
	add_column :moving_averages, :name, :string
  end
end
