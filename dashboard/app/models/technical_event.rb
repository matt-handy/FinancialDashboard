class TechnicalEvent < ActiveRecord::Base
  belongs_to :indicator
  
  def self.generate_technicals
    TechnicalEvent.all.destroy_all
    TechnicalEvent.find_golden_and_death_cross
  end
  
  def self.find_golden_and_death_cross
    fiftyDay = MovingAverage.where(name: "50 Day SMA").first
	twoHDay = MovingAverage.where(name: "200 Day SMA").first
	twoHDaySamples = []
	
    Indicator.all.each { |i|
	  fiftyDaySamples = i.average_samples.where(:moving_average_id => fiftyDay.id).order(stamp: :desc).limit(60)
	  twoHDaySamples = i.average_samples.where(:moving_average_id => twoHDay.id).order(stamp: :desc).limit(60)
	  idx = twoHDaySamples.size - 1
	  fiftyAbove = nil
	  
	  if fiftyDaySamples.size != twoHDaySamples.size
	    break
	  end
	  
	  while idx >= 0
	    fDaySample = fiftyDaySamples[idx]
		tDaySample = twoHDaySamples[idx]
		
		#puts "#{idx}-#{fDaySample.stamp}: FD - #{fDaySample.value}, TD - #{tDaySample.value}"
		
		if fDaySample.stamp != tDaySample.stamp
		  puts "#{i.name}: sample timestamps out of sync"
		  break
		end
		
		if idx == twoHDaySamples.size - 1
		  fiftyAbove = fDaySample.value > tDaySample.value
		elsif fiftyAbove == true
		  if fDaySample.value < tDaySample.value
		    puts "#{i.name}: Death cross detected on #{fDaySample.stamp}, FD: #{fDaySample.value} - TD: #{tDaySample.value}"
			fiftyAbove = false
			te = TechnicalEvent.new(:indicator_id => i.id, :stamp => fDaySample.stamp, :name => "Death Cross")
			te.save
		  end
		else
		  if fDaySample.value > tDaySample.value
		    puts "#{i.name}: Golden cross detected on #{fDaySample.stamp}"
			fiftyAbove = true
			te = TechnicalEvent.new(:indicator_id => i.id, :stamp => fDaySample.stamp, :name => "Golden Cross")
			te.save
		  end
		end
		
	    idx = idx - 1
	  end
	}
  end
  
end
