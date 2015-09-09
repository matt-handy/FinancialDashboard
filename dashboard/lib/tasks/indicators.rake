require 'open-uri'

namespace :indicators do
  desc "TODO"
  task load: :environment do
    Indicator.all.each { |i|
      i.datapoints.destroy_all
      url = URI.parse(i.uri)
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
  end

end