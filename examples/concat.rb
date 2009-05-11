require 'rubygems'
$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'

class StringConcat < Steve
  subject "Combining strings"
end

plus = StringConcat.new "plus" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali" + "docious"
    end
  end
  
end

append = StringConcat.new "appending strings" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali" << "docious"
    end
  end
  
end

interpolate = StringConcat.new "interpolating strings" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali#{'docious'}"
    end
  end
  
end

# append.load("append")
# interpolate.load("interpolate")

run_count, sample_size = 3, 8
# 
# puts "Measuring #{run_count} runs of #{sample_size} for each test."
# StringConcat.run([append, interpolate], run_count, sample_size)
# puts
# StringConcat.report([append, interpolate])
# append.dump
# interpolate.dump

StringConcat.compare_instances( 3, 8)
