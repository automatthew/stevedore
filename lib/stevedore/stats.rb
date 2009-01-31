class Stevedore
  
  module Stats
    
    def sum
      s = 0; self.each { |element| s = s + element }; s
    end
    
    def mean
      self.sum.to_f / self.size
    end
    
    def variance
      n = self.size
      denom = n - 1
      m = self.mean
      s = 0
      self.each { |element| s = s + (element - m)**2; }
      s / denom
    end
    
    def standard_deviation
      Math.sqrt( self.variance )
    end
    
    def median
      sorted = self.sort; i = sorted.size % 2
      case i
       when 0 then sorted[i/2 - 1, 2].mean
       when 1 then sorted[i/2].to_f
      end if sorted.size > 0
    end
    
    def self.power_test(*args)
      Stevedore::ShellR.new.power_test(*args)
    end
        
  end
  
end

