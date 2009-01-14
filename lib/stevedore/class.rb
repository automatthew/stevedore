class Stevedore
  
  def self.instances; @instances ||= []; end
  
  def self.reset; @instances = []; end
  
  
  # Moderately stringent defaults for power analysis
  
  def self.power(val=nil)
    val ? @power = val : @power ||= 0.9
  end
  def self.sig_level(val=nil)
    val ? @sig_level = val : @sig_level ||= 0.01
  end
  def self.delta(val=nil)
    val ? @delta = val : @delta ||= 0.001
  end
  
  def self.subject(val=nil)
    @subject ||= val
  end
  
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
  
  def self.compare_instances(run_count, sample_size)
    puts
    puts "Benchmark: #{@subject}" if @subject
    puts
    puts "Measuring #{run_count} runs of #{sample_size} for each test."
    @instances.each do |instance|
      instance.go(run_count, sample_size) if instance.samples.empty?
    end
    puts
    puts @subject if @subject
    name_size = @instances.map { |i| i.name.size }.max
    puts "\n%-#{name_size}s %12s %12s %12s %12s %12s" % ["", "Mean", "Stddev", "Minimum", "Median", "Max"]
    puts "-" * (name_size + 5 * 13)
    @instances.sort_by { |i| i.mean }.each do |instance|
      puts "%-#{name_size}s %12f %12f %12f %12f %12f" % 
        [ instance.name, instance.mean, instance.standard_deviation, instance.min, instance.median, instance.max]
    end
    means = @instances.map { |i| i.mean }.sort
    baseline = means.shift
    diffs = means.map { |m| m / baseline }
    puts "Difference in means:  #{diffs.join(', ')}"
    n = run_count * sample_size
    stddev = @instances.map { |i| i.standard_deviation }.max
    puts
    puts "Significant delta at current power settings: #{self.calculated_delta(n, stddev)}"
    puts
  end
  
  # Run a small set of samples and use a power test to determine
  # the optimal run count and sample size.
  def self.recommend_test_size(run_count, sample_size)
    puts "\nRunning trials (#{run_count} runs of #{sample_size}) for each instance.\n\n"
    @instances.each do |instance|
      puts "'#{instance.name}'"
      instance.go(run_count, sample_size)
      puts "  Mean: %6f" % instance.mean
      puts "  Stddev: %6f" % instance.standard_deviation
    end
    puts
    worst = @instances.sort_by { |i| i.standard_deviation }.last
    puts "'#{worst.name}' has the greatest standard deviation,"
    puts "so we'll use it in the power test to determine optimal run size"
    rec_size = optimal_n(worst.standard_deviation).to_i
    rec_runs = optimal_n(worst.sample_means.standard_deviation).to_i
    puts "Recommendation: #{rec_runs} sample runs of #{rec_size} measurements.\n\n"
    [rec_runs, rec_size]
  end
  
  def self.optimal_n(stddev);
    args = { :power => power, :delta => delta, :sig_level => sig_level, :sd => stddev }
    Stevedore::Stats.power_test(args)["n"].to_i
  end
  
  def self.calculated_power(n, d, std)
    args = { :n => n,  :delta => d, :sig_level => sig_level, :sd => std }
    puts args.inspect
    Stevedore::Stats.power_test(args)["power"]
  end
  
  def self.calculated_delta(n, std)
    args = { :n => n, :power => power, :sig_level => sig_level, :sd => std }
    Stevedore::Stats.power_test(args)["delta"]
  end
  
end