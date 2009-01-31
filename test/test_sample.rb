require "#{File.dirname(__FILE__)}/helper.rb"

Sample = Stevedore::Sample

describe "Stevedore::Sample" do
  
  before do
    @sample = Sample.new((1..40).to_a)
    @nested_sample = Sample.new [Sample.new((1..40).to_a), Sample.new((1..40).to_a), Sample.new((1..40).to_a) ]
  end
  
  it "a flattened Sample is still a Sample" do
    @nested_sample.flatten.class.should == Sample
    [@nested_sample].flatten.class.should == Array
  end
  
  it "has a mean" do
    @sample.mean.should == 20.5
    @nested_sample.mean.should == 20.5
  end
  
  it "has a standard deviation" do
    @sample.standard_deviation.to_i.should == 11
    @nested_sample.standard_deviation.to_i.should == 11
  end
  
  it "can become simple arrays" do
    @nested_sample.to_a.each do |a|
      a.class.should == Array
    end
  end
  
end