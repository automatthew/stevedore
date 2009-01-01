%w{ rubygems  }.each { |dep| require dep  }
require 'rstats'
require 'mathstats'
require 'rsruby'

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'

array = YAML.load_file("data.yml")

rstats_sd = Stevedore.new "rstats standard deviation" do
  
  measure do
    array.standard_deviation
  end
  
end

mathstats = Stevedore.new "mathstats standard deviation" do
  
  measure do
    Mathstats::Lib.standard_deviation(array)
  end
  
end

rsruby = Stevedore.new "rsruby standard deviation" do
  
  before do
    @r = RSRuby.instance
  end
  
  measure do
    @r.sd(array)
  end
  
end


Stevedore.compare_instances(5, 10)


