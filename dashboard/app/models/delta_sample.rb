class DeltaSample < ActiveRecord::Base
  belongs_to :indicator
  belongs_to :price_delta_category
end
