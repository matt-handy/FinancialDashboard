class PlotToFamily < ActiveRecord::Base
  belongs_to :plot_family
  belongs_to :plot
end
