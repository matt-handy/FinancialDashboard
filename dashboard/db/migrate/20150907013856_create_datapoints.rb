class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.date :day
      t.float :value

      t.timestamps null: false
    end
  end
end
