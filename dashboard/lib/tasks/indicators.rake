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
	MovingAverage.update_all_indicators
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

    MovingAverage.build_all_indicators	
  end
  
  task backup: :environment do
    File.open(File.join("db","plot_families.xml"), "w") { |file| file.write PlotFamily.all.to_xml() }
	File.open(File.join("db","indicators.xml"), "w") { |file| file.write Indicator.all.to_xml() }
	File.open(File.join("db","plots.xml"), "w") { |file| file.write Plot.all.to_xml() }
	File.open(File.join("db","plot_to_families.xml"), "w") { |file| file.write PlotToFamily.all.to_xml() }
	File.open(File.join("db","series.xml"), "w") { |file| file.write Series.all.to_xml() }
  end
  
  task rebuild: :environment do
    MovingAverage.define_all
	
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
	
    PlotFamily.d_initialize("db/plot_families.xml")
	Indicator.d_initialize("db/indicators.xml")
	Plot.d_initialize("db/plots.xml")
	PlotToFamily.d_initialize("db/plot_to_families.xml")
	Series.d_initialize("db/series.xml")
  end
  
end
