class PlotFamily < ActiveRecord::Base
  has_many :plot_to_families
  has_many :plots, through: :plot_to_families
end
