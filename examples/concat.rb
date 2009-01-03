require 'rubygems'
$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'


plus = Steve.new "Combining strings with +" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali" + "docious"
    end
  end
  
end

append = Steve.new "Combining strings with <<" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali" << "docious"
    end
  end
  
end

interpolate = Steve.new "Combining strings with interpolation" do
  
  measure do
    10000.times do
      "supercalifragilisticexpiali#{'docious'}"
    end
  end
  
end

Steve.compare_instances(5, 50)
