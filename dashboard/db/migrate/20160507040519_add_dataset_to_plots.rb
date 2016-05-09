class AddDatasetToPlots < ActiveRecord::Migration
  def change
    add_column :plots, :dataset, :string
  end
end
