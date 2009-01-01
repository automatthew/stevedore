%w{ rubygems  }.each { |dep| require dep  }

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'

thing = lambda { true }
n = 10000

one_eval = Stevedore.new "One instance eval with several block.call" do
  
  measure do
    instance_eval do
      n.times { thing.call }
    end
  end
  
end

multi_eval = Stevedore.new "instance_eval &block multiple times" do
  
  measure do
    n.times { instance_eval &thing }
  end
  
end

# multi_eval.go(1,50)
# 
# File.open "data.yml", "w" do |f|
#   f.print multi_eval.samples.flatten.to_yaml
# end

Stevedore.compare_instances(5, 10)
puts
puts
Stevedore.recommend_test_size(2, 4)

