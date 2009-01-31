%w{ rubygems  }.each { |dep| require dep  }
require 'mathstats'
require 'rsruby'

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'

srand(2009)
array = (1..2000).to_a.map { |i| rand(800.0) }

rsruby = Stevedore.new "rsruby standard deviation" do
  
  before do
    @r = RSRuby.instance
  end
  
  measure do
    @r.sd(array)
  end
  
end

mathstats = Stevedore.new "mathstats standard deviation" do
  
  measure do
    Mathstats::Lib.standard_deviation(array)
  end
  
end

steve_stats = Stevedore.new "steve's own stats" do
  before do
    array.extend Stevedore::Stats
  end
  measure do
    array.standard_deviation
  end
end


Stevedore.compare_instances(5, 25)


