class Stevedore
  begin
    require 'stevedore/rsruby'
    Stats = Stevedore::RSRuby
    puts "Using RSRuby"
  rescue
    require 'mathstats'
    Stats = Mathstats
    module Stats
      unless defined?(median)
        def median
          sorted = self.sort; i = sorted.size % 2
          case i
           when 0 then sorted[i/2 - 1, 2].mean
           when 1 then sorted[i/2].to_f
          end if sorted.size > 0
        end
      end
      def self.power_test(*args)
        Stevedore::ShellR.new.power_test(*args)
      end
    end
    puts "using Mathstats"
  end

  Array.send :include, Stats
    
  def sample_means
    @samples.map { |s| s.mean }
  end
  
  def sample_standard_deviations
    @samples.map { |s| s.standard_deviation }
  end
  
  def mean
    self.flattened_samples.mean
  end
  
  def standard_deviation
    self.flattened_samples.standard_deviation
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
  
end

