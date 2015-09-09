class Series < ActiveRecord::Base
  belongs_to :indicator
  belongs_to :plot
end
