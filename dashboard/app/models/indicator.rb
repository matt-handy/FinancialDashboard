class Indicator < ActiveRecord::Base
  has_many :datapoints, dependent: :destroy
  has_many :series
  has_many :plots, through: :series
  has_many :average_samples
  has_many :technical_events
end
