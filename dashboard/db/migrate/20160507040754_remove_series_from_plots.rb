class RemoveSeriesFromPlots < ActiveRecord::Migration
  def change
    remove_column :plots, :series, :string
  end
end
