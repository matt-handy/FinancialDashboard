class Plot < ActiveRecord::Base
  has_many :series
  has_many :indicators, through: :series
  has_many :plot_to_families
  has_many :plot_families, through: :plot_to_families
end
