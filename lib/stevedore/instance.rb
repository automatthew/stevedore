require 'fileutils'
class Stevedore
  
  attr_accessor :name, :description, :samples
  
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
  
  def flattened_samples
     @flat ||= @samples.flatten
  end
  
  def reset
    @samples = []
    @flattened_samples = []
  end
  
  def dump(name)
    filename = dump_path(name)
    FileUtils.mkdir_p(File.dirname(filename))
    File.open filename, "w" do |f|
      Marshal.dump(@samples, f)
    end
  end
  
  def load(name)
    filename = dump_path(name)
    str = File.read(filename)
    @samples = Marshal.load(str)
  end
  
  def dump_path(name)
    "stevedata/#{name}"
  end
  
  
  # Blocks for setup and measurement
  
  def before(&block); @before = block; end
  
  def after(&block); @after = block; end
  
  def before_sample(&block); @before_sample = block; end
  
  def after_sample(&block); @after_sample = block; end
  
  def before_measure(&block); @before_measure = block; end
  
  def after_measure(&block); @after_measure = block; end
  
  # Here you do the work you actually want to measure.
  def measure(&block); @measure = block; end
  
  def go(run_count, sample_size)
    reset
    instance_eval( &@before ) if @before
    
    run_count.times do
      sample = []
      instance_eval( &@before_sample ) if @before_sample
      
      print "."; $stdout.flush
      sample_size.times do
        instance_eval( &@before_measure ) if @before_measure
        
        sample << Benchmark.realtime { instance_eval( &@measure ) }
        
        instance_eval( &@after_measure ) if @after_measure
      end
      instance_eval( &@after_sample ) if @after_sample
      @samples << sample
    end
    puts; $stdout.flush
    instance_eval( &@after ) if @after
    dump(@name)
  end
  
  def report
    puts self.name
    puts "  Mean: #{self.mean}"
    puts "  Standard deviation: #{self.standard_deviation}"
    puts
  end
  
  def mean
    self.flattened_samples.mean
  end
  
  def median
    self.flattened_samples.median
  end
  
  def min
    self.flattened_samples.min
  end
  
  def max
    self.flattened_samples.max
  end
  
  def standard_deviation
    self.flattened_samples.standard_deviation
  end
  
  def sample_means
    @samples.map { |s| s.mean }
  end
  
  
  
end