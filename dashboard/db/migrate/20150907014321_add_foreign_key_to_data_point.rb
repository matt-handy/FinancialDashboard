class AddForeignKeyToDataPoint < ActiveRecord::Migration
  def change
    add_column :datapoints, :customer_id, :integer
    add_index :datapoints, :customer_id
  end
end
