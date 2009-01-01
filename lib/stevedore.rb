require 'mathstats'
require 'benchmark'
require 'stevedore/mathstats'
require 'stevedore/stats'
require 'stevedore/shell_r'

class Stevedore
  
  Stats = Stevedore::MathstatsMethods
  
  attr_accessor :name, :samples, :delta, :sig_level, :power
  
  def initialize(name, description='', &block)
    klass = self.class
    klass.instances << self
    @before, @after = klass.before, klass.after
    @before_measure, @after_measure = klass.before_measure, klass.after_measure
    @before_sample, @after_sample = klass.before_sample, klass.after_sample
    @name, @description = name, description
    @samples = []
    instance_eval( &block ) if block
  end
  
  def reset
    @samples = []
    @flattened_samples = []
  end
  
  def go(run_count, sample_size)
    reset
    instance_eval( &@before ) if @before
    run_count.times do |i|
      sample = []
      instance_eval( &@before_sample ) if @before_sample
      sample_size.times do
        instance_eval( &@before_measure ) if @before_measure
        sample << Benchmark.realtime do          
          instance_eval( &@measure )
        end
        instance_eval( &@after_measure ) if @after_measure
      end
      instance_eval( &@after_sample ) if @after_sample
      @samples << sample
    end
    instance_eval( &@after ) if @after
  end
  
  # Define a block to evaluate before any samples are taken
  def before(&block); @before = block; end
  
  # Define a block to evaluate after all samples have been taken
  def after(&block); @after = block; end
  
  # Define a block to evaluate before each sample run
  def before_sample(&block); @before_sample = block; end
  
  # Define a block to evaluate after each sample run
  def after_sample(&block); @after_sample = block; end
  
  # Define a block to evaluate before each measurement
  def before_measure(&block); @before_measure = block; end
  
  # Define a block to evaluate after each measurement
  def after_measure(&block); @after_measure = block; end
  
  def measure(&block); @measure = block; end
  
  

  
  # statistics
  
  def flattened_samples
     @flat ||= @samples.flatten
  end
  

  
  def power_test(sd)
    raise "need to shell out, guy"
    # self.class.power_test(@r, sd)
  end
  
  def report
    puts self.name
    puts "#{run_count} sample runs, #{sample_size} measurements each"
    puts "  Mean: #{self.mean}"
    puts "  Standard deviation: #{self.standard_deviation}"
    puts
  end
  
  # class << self
  #   attr_accessor :path_to_R, :power, :sig_level, :delta
  # end
  
  def self.instances; @instances ||= []; end
  
  def self.reset; @instances = []; end
  
  def self.power(val=nil); val ? @power = val : @power ||= 0.9; end
  def self.sig_level(val=nil); val ? @sig_level = val : @sig_level ||= 0.01; end
  def self.delta(val=nil); val ? @delta = val : @delta ||= 0.001; end
  
  
  def self.before(&block)
    block ? @before = block : @before
  end
  
  def self.after(&block)
    block ? @after = block : @after
  end
  
  def self.before_sample(&block)
    block ? @before_sample = block : @before_sample
  end
  
  def self.after_sample(&block)
    block ? @after_sample = block : @after_sample
  end
  
  def self.before_measure(&block)
    block ? @before_measure = block : @before_measure
  end  
  
  def self.after_measure(&block)
    block ? @after_measure = block : @after_measure
  end
  
  # Run a small set of samples and use a power test to determine
  # the optimal run count and sample size.
  def self.recommend_test_size(run_count, sample_size)
    raise "broken because we haven't made a way to shell out to R"
    puts "\nRunning trials (#{run_count} runs of #{sample_size}) for each instance.\n\n"
    @instances.each do |instance|
      print "'#{instance.name}'"
      instance.go(run_count, sample_size)
      puts "  Mean: %6f" % instance.mean
      puts "  Stddev: %6f" % instance.standard_deviation
    end
    puts
    worst = @instances.sort_by { |i| i.standard_deviation }.last
    puts "'#{worst.name}' has the greatest standard deviation,"
    puts "so we'll use it in the power test to determine optimal run size"
    rec_size = optimal_n(worst.standard_deviation).to_i
    # rec_size = power_test(r, worst.standard_deviation )['n'].to_i
    rec_runs = optimal_n(worst.sample_means.standard_deviation).to_i
    # rec_runs = power_test(r, r.sd( worst.sample_means) )['n'].to_i
    puts "Recommendation: #{rec_runs} sample runs of #{rec_size} measurements.\n\n"
    [rec_runs, rec_size]
  end
  
  def self.optimal_n(stddev);
    
    args = { :power => power, :delta => delta, :sig_level => sig_level, :sd => stddev }
    Stevedore::ShellR.new.power_test(args)[:n]
  end
  
  def self.power_test(r, sd)
    raise "need to shell out, buddy"
    if sd < 0.00007
      warn "Stddev is very small, which makes power.t.test sad. \nSetting stddev to 0.00007 so we can get this done."
      sd = 0.00007
    end
    r.power_t_test :delta => delta, :power => power, :sig_level => sig_level, :sd => sd 
    expression = %Q{power.t.test(power=0.9, delta=0.0001, sd=#{sd}, sig.level=0.01)["n"]}
  end
  
  def self.shell_R(expression)
    command = %Q{#{path_to_R} --slave -e '#{expression}'}
    command
  end
  
  def self.compare_instances(run_count, sample_size)
    puts "Measuring #{run_count} runs of #{sample_size} for each instance.\n\n"
    @instances.each do |instance|
      puts "'#{instance.name}'"
      instance.go(run_count, sample_size)
    end
    name_size = @instances.map { |i| i.name.size }.max
    puts "\n%-#{name_size}s %12s %12s %12s %12s %12s" % %w{ Name Mean Stddev Minimum Median Max  }
    puts "-" * (name_size + 5 * 13)
    @instances.each do |instance|
      puts "%-#{name_size}s %12f %12f %12f %12f %12f" % 
        [ instance.name, instance.mean, instance.standard_deviation, instance.min, instance.median, instance.max]
    end
    puts
  end
  
end

Steve = Stevedore