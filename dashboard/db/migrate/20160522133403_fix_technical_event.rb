class FixTechnicalEvent < ActiveRecord::Migration
  def change
    remove_column :technical_events, :type
	
	add_column :technical_events, :name, :string
  end
end
