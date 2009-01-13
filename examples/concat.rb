require 'rubygems'
$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'

class StringConcat < Steve
  subject "Combining strings"
end
# 
# plus = StringConcat.new "plus" do
#   
#   measure do
#     10000.times do
#       "supercalifragilisticexpiali" + "docious"
#     end
#   end
#   
# end

append = StringConcat.new "append" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali" << "docious"
    end
  end
  
end

interpolate = StringConcat.new "interpolate" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali#{'docious'}"
    end
  end
  
end

append.load("append")
interpolate.load("interpolate")

StringConcat.compare_instances(8, 64)

