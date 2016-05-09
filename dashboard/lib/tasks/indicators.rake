require 'open-uri'

namespace :indicators do
  desc "TODO"
  task load: :environment do
    Indicator.all.each { |i|
      #url = URI.parse(i.uri)
	  url = URI.parse("http://www.google.com/finance/historical?cid=#{i.uri}&startdate=Sep+10%2C+1975&num=25000&output=csv")
	  
      open(url) do |http|
        response = http.read
        lines = response.inspect.to_s.split("\\n")
	    idx = 0
		proceed = true
		lines.shift
		while(proceed && lines.size() > 0)
		  line = lines.shift
		  elems = line.split(",")
	      if elems.size() == 6
	        day = elems[0]
	        close_val = elems[4]
			puts "#{i.name}: #{day}"
			day_obj = Date.parse(day)
			if(i.datapoints.where(:day => day_obj).count == 0) 
	          i.datapoints.create(day: Date.parse(day), value: close_val.to_f)
			else
              puts "#{i.name}: Match for date #{day}"
			  proceed = false			  
			end
	      end
		end
      end
    }
	
	Plot.all.each { |p| p.regenerate_series }
	PriceDeltaCategory.regenerate_all
  end
  
  task reload: :environment do
    Indicator.all.each { |i|
      i.datapoints.destroy_all
      #url = URI.parse(i.uri)
	  url = URI.parse("http://www.google.com/finance/historical?cid=#{i.uri}&startdate=Sep+10%2C+1975&num=25000&output=csv")
      open(url) do |http|
        response = http.read
        lines = response.inspect.to_s.split("\\n")
	    idx = 0
	    lines.each { |line|
	      if not idx == 0
	        elems = line.split(",")
	        if elems.size == 6
	          day = elems[0]
	          close_val = elems[4]
	          i.datapoints.create(day: Date.parse(day), value: close_val.to_f)
	        end
	      end
	      idx = idx + 1
	    }  
      end
    }
	
	Plot.all.each { |p| p.regenerate_series }
	PriceDeltaCategory.regenerate_all
  end
  
  task backup: :environment do
    PriceDeltaCategory.destroy_all
    #40% in 12 weeks
	catThreeMonths = PriceDeltaCategory.new(:length => 60, :title => "12 Weeks, 40%", :delta => 40)
	catThreeMonths.save
	
	#25% in 8 weeks
	catTwoMonths = PriceDeltaCategory.new(:length => 40, :title => "8 Weeks, 25%", :delta => 25)
	catTwoMonths.save
	
	#25% in 8 weeks
	catOneMonths = PriceDeltaCategory.new(:length => 20, :title => "4 Weeks, 15%", :delta => 15)
	catOneMonths.save
	
	PriceDeltaCategory.regenerate_all
  end
  
end
