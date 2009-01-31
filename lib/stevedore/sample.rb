begin
  require 'stevedore/rsruby'
  Stats = Stevedore::RSRuby
rescue LoadError
  gem "bmarini-mathstats"
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
end

class Stevedore
  
  class Sample < Array
    include Stats
    
    attr_reader :flat
    
    alias :old_mean :mean
    alias :old_sd :standard_deviation
    alias :old_median :median
    alias :old_min :min
    alias :old_max :max
    
    def mean; (@flat ||= self.flatten).old_mean; end

    def standard_deviation; (@flat ||= self.flatten).old_sd; end
    
    def median; (@flat ||= self.flatten).old_median; end
    
    def min; (@flat ||= self.flatten).old_min; end
    
    def max; (@flat ||= self.flatten).old_max; end
    
  end
  
end