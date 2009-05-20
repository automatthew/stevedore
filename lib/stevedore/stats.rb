class Stevedore
  
  module Stats
    # require 'ffi'
    # extend FFI::Library
    # attach_function :sqrt, [:double], :double
    # 
    # 
    
    def sum
      s = 0; self.each { |element| s += element }; s
    end
    
    def mean
      self.sum.to_f / self.size
    end
    
    def variance
      denom = self.size - 1
      m = self.mean
      s = 0
      self.each { |element| s += (element - m)**2; }
      s / denom
    end
    
    def standard_deviation
      Math.sqrt( self.variance )
    end
    
    def median
      sorted = self.sort; 
      s = sorted.size
      i = s % 2
      case i
       when 0 then sorted[s/2 - 1, 2].mean
       when 1 then sorted[s/2].to_f
      end if sorted.size > 0
    end
    
    # def self.power_test(*args)
    #   Stevedore::ShellR.new.power_test(*args)
    # end
        
  end
  
end

