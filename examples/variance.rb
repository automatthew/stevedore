require 'rubygems'
$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'stevedore'


def variance_two_pass(array, mean)
  n        = array.size
  denom    =  n - 1 
  variance = array.inject(0) {|memo, element| memo + (element - mean)**2 } / denom
end

def my_var(array, mean)
  n        = array.size
  denom    =  n - 1
  s = 0
  array.each { |element| s = s + (element - mean)**2; }
  s / denom
end

def for_var(array, mean)
  n        = array.size
  denom    =  n - 1
  s = 0
  for element in array
    s = s + (element - mean)**2
  end
  s / denom
end




class Variances < Steve
  subject = "Calculating a statistical variance"
  before do
    srand(2009)
    @array = (1..2000).to_a.map { |i| rand(800.0) }
    s = 0; @array.each { |element| s = s + element }
    @sum = s
    @mean = @sum / @array.size.to_f
  end
end


mathstats = Variances.new "bmarini-mathstats" do
  measure do
    @var = variance_two_pass(@array, @mean)
  end
end

no_inject = Variances.new "not using inject" do
  measure do
    @var = my_var(@array, @mean)
  end
end

for_loop = Variances.new "using for loop" do
  measure do
    @var = for_var(@array, @mean)
  end
end

Variances.compare_instances(8, 32)
