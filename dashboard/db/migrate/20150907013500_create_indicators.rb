class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :uri

      t.timestamps null: false
    end
  end
end
