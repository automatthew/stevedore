begin
  require 'stevedore/rsruby'
  Stats = Stevedore::RSRuby
rescue LoadError
  require 'stevedore/stats'
end

class Stevedore
  
  class Sample < Array
    include Stats
    
    attr_reader :flat
    
    alias :old_to_a :to_a
    alias :old_mean :mean
    alias :old_sd :standard_deviation
    alias :old_median :median
    alias :old_min :min
    alias :old_max :max
    
    def to_a
      self.map { |a| a.is_a?( Sample ) ? a.to_a : a  }
    end
    
    def mean; (@flat ||= self.flatten).old_mean; end

    def standard_deviation; (@flat ||= self.flatten).old_sd; end
    
    def median; (@flat ||= self.flatten).old_median; end
    
    def min; (@flat ||= self.flatten).old_min; end
    
    def max; (@flat ||= self.flatten).old_max; end
    
  end
  
end