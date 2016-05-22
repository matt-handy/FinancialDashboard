class MovingAverage < ActiveRecord::Base
  #Note to self, this code is aweful. Seriously. Revisit sometime in the morning.
  def self.define_all
    MovingAverage.destroy_all
	fiftyDay = MovingAverage.new(:period => 50, :name => "50 Day SMA")
	fiftyDay.save
	twoHDay = MovingAverage.new(:period => 200, :name => "200 Day SMA")
	twoHDay.save
	twoTDay = MovingAverage.new(:period => 2000, :name => "2000 Day SMA")
	twoTDay.save
  end
  
  def self.update_all_indicators

    fiftyDay = MovingAverage.where(name: "50 Day SMA").first
	fiftyDaySamples = []
	twoHDay = MovingAverage.where(name: "200 Day SMA").first
	twoHDaySamples = []
	twoTDay = MovingAverage.where(name: "2000 Day SMA").first
	twoTDaySamples = []
	
	Indicator.all.each { |i|
	  puts "Processing: #{i.name}"
	  i.datapoints.order(day: :desc).each{ |dp|
	  
	    if not i.average_samples.where(:stamp => dp.day).blank?
		  puts "Found averages for date #{dp.day}, breaking"
		  break
		end
		
		i.datapoints.order(day: :desc).limit(fiftyDay.period).each { |dp|
		  fiftyDaySamples << dp.value
		}
		as = AverageSample.new(:moving_average_id => fiftyDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(fiftyDaySamples), :stamp => dp.day)
		as.save
	
		i.datapoints.order(day: :desc).limit(twoHDay.period).each { |dp|
		  twoHDaySamples << dp.value
		}
		as = AverageSample.new(:moving_average_id => twoHDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(twoHDaySamples), :stamp => dp.day)
		as.save
		
		i.datapoints.order(day: :desc).limit(twoTDay.period).each { |dp|
		  twoTDaySamples << dp.value
		}
		as = AverageSample.new(:moving_average_id => twoTDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(twoTDaySamples), :stamp => dp.day)
		as.save

	  }
	}

  end
  
  def self.build_all_indicators
    fiftyDay = MovingAverage.where(name: "50 Day SMA").first
	fiftyDaySamples = []
	twoHDay = MovingAverage.where(name: "200 Day SMA").first
	twoHDaySamples = []
	twoTDay = MovingAverage.where(name: "2000 Day SMA").first
	twoTDaySamples = []
	
    Indicator.all.each { |i|
	  puts "Processing: #{i.name}"
	  i.average_samples.destroy_all
	  i.datapoints.order(:day).each{ |dp|
	    fiftyDaySamples << dp.value
		while fiftyDaySamples.size > fiftyDay.period
		  fiftyDaySamples.shift
		end
		as = AverageSample.new(:moving_average_id => fiftyDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(fiftyDaySamples), :stamp => dp.day)
		as.save
		
		twoHDaySamples << dp.value
		while twoHDaySamples.size > twoHDay.period
		  twoHDaySamples.shift
		end
		as = AverageSample.new(:moving_average_id => twoHDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(twoHDaySamples), :stamp => dp.day)
		as.save
		
		twoTDaySamples << dp.value
		while twoTDaySamples.size > twoTDay.period
		  twoTDaySamples.shift
		end
		as = AverageSample.new(:moving_average_id => twoTDay.id, :indicator_id => i.id, :value => MovingAverage.get_average(twoTDaySamples), :stamp => dp.day)
		as.save
      }
	}
  end
  
  def self.get_average(elements)
    running_total = 0
	elements.each { |e|
	  running_total = running_total + e
	}
	running_total / elements.size
  end
end
