class CreateTechnicalEvents < ActiveRecord::Migration
  def change
    create_table :technical_events do |t|
      t.string :type
      t.integer :indicator_id
      t.date :stamp

      t.timestamps null: false
    end
  end
end
