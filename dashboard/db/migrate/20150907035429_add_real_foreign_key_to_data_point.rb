class AddRealForeignKeyToDataPoint < ActiveRecord::Migration
  def change
    remove_column :datapoints, :customer_id
    add_column :datapoints, :indicator_id, :integer
    add_index :datapoints, :indicator_id
  end
end
