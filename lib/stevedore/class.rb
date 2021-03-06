require 'ruport'
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
  
  # Heritable blocks for setup and measurement
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
  
  def self.run(instances, run_count, sample_size)
    instances.each do |instance|
      instance.go(run_count, sample_size)
    end
  end
  
  def self.run_all(run_count, sample_size)
    run(@instances, run_count, sample_size)
  end
  
  def self.report_all
    report(@instances)
  end
  
  def self.report(instances)
    table = Ruport::Data::Table.new :column_names => %w{ desc Mean ratio Stddev Min Median Max }, :alignment => :right
    feeder = Ruport::Data::Feeder.new(table)
    feeder.transform do |r|
      r.attributes.each do |k|
        v = r[k]
        r[k] = ("%.7f" % v).to_f if v.is_a? Float
      end
    end
    means = instances.map { |i| i.mean }.sort
    baseline = means.first
    instances.sort_by { |i| i.mean }.each do |i|
      feeder << [ i.name, i.mean, i.mean / baseline, i.standard_deviation, i.min, i.median, i.max]
    end
    table.rename_columns "ratio" => "this/fastest", "desc" => "Description"
    puts table
  end
  
  def self.compare_instances(run_count, sample_size)
    puts
    puts "Benchmark: #{@subject}" if @subject
    puts
    puts "Measuring #{run_count} runs of #{sample_size} for each test."
    self.run_all(run_count, sample_size)
    puts
    self.report(@instances)
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