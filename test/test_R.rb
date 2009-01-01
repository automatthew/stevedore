require "#{File.dirname(__FILE__)}/helper.rb"

R = Stevedore::ShellR

describe "Steve.optimal_n" do
  
  it "works" do
    Stevedore.power 0.9
    Stevedore.delta 0.003
    Stevedore.sig_level 0.01
    Stevedore.optimal_n( 0.02 ).should == 1324.272
  end
  
end


describe "ShellR class" do
  
  it "tries to find the path to R using `which`" do
    File.exist?(R.path).should == true
  end
  
  it "allows you to set the path to R" do
    R.path "/monkey"
    R.path.should == "/monkey"
  end
  
end

describe "An instance of ShellR" do
  
  before do
    @r = R.new
  end
  
  it "gets the path to R from the class" do
    R.path "/junkie"
    @r.path.should == "/junkie"
  end
  
  it "properly constructs the shell command" do
    @r.command("shines").should == "/junkie --slave -e 'shines'"
  end
  
  it "can shell out to call R" do
    R.path  `which R`.chomp
    expression = %Q{power.t.test(power=0.9, delta=0.0001, sd=0.001133, sig.level=0.01)["n"]}
    res = @r.execute(expression)
    res.should == "$n\n[1] 3821.76\n\n"
  end
  
  it "can scan the R result when printed as list of attrs" do
    output = <<-TXT
$n
[1] 3821.76

$delta
[1] 1e-04

    TXT
    @r.parse(output).should ==  { :n => 3821.76, :delta => 1e-04 }
  end
  
  it "has a power_test method" do
    options = {:power => 0.9, :delta => 0.003, :sig_level => 0.01, :sd => 0.02}
    res = @r.power_test(options)
    res.should == { :power => 0.9, :delta => 0.003, :sig_level => 0.01, :sd => 0.02, :n => 1324.272 }
  end
  
  
end
