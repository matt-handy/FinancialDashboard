class AverageSample < ActiveRecord::Base
  belongs_to :indicator
  belongs_to :moving_average
end
