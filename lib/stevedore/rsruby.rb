class Stevedore
  
  module RSRubyMethods
    
    def mean(array)
      r.mean(array)
    end
    
    def standard_deviation(array)
      r.sd(array)
    end
    
    def median(array)
      r.median(array)
    end
    
    def power_test(args)
      
    end
    
    module_function :mean, :standard_deviation, :median
    
  end
  
end