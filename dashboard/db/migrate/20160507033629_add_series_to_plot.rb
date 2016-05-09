class AddSeriesToPlot < ActiveRecord::Migration
  def change
    add_column :plots, :series, :string
  end
end
