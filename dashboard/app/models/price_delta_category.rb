class PriceDeltaCategory < ActiveRecord::Base
  has_many :delta_samples
  
  def self.regenerate_all
    PriceDeltaCategory.all.each { |pdc|
	  pdc.regenerate_samples
	}
  end
  
  def regenerate_samples
    self.delta_samples.delete_all
	
	targetDelta = self.delta / 100.0
	puts targetDelta
	
	Indicator.all.each{ |i|
	  #gets most recent first
	  counter = 1 
	  firstVal = -1
	  targetVal = -1
	  i.datapoints.order(day: :desc).each{ |dp|
	    if counter == 1
		  firstVal = dp.value
		elsif counter == self.length
		  targetVal = dp.value
		  break
		end
		
		counter = counter + 1
      }
	  
	  percent_change = (firstVal - targetVal) / targetVal
	  
	  if percent_change > targetDelta or percent_change < (targetDelta * -1)
	    puts "#{i.name}: #{percent_change}, start: #{firstVal}, end: #{targetVal}"
		s = DeltaSample.new(:indicator_id => i.id, :price_delta_category_id => self.id, :value => percent_change)
        s.save
	  end
	}
  end
  
end
