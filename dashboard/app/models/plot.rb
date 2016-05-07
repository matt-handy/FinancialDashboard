class Plot < ActiveRecord::Base
  has_many :series
  has_many :indicators, through: :series
  has_many :plot_to_families
  has_many :plot_families, through: :plot_to_families
  
  def regenerate_series
    series_str = ""
	
	first = true
    self.indicators.each{ |i|
      if first
        first = false
      else
        series_str << ","
	  end
      series_str << "{\n"
      series_str << "name: '#{i.name}',\n" 
      series_str << "data: [\n"
      i.datapoints.order(:day).each{ |dp|
	    if Date.today - dp.day <= self.days_duration
          series_str << "[Date.UTC(#{dp.day.year},#{dp.day.mon - 1},#{dp.day.mday}),#{dp.value}],\n"
	    end
      }
      series_str << "]\n"
      series_str << "}\n"
    }
  
	self.dataset = series_str.html_safe
	self.save
  end
end
