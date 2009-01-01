class Stevedore
  
  module MathstatsMethods
    
    def mean(array)
      ::Mathstats::Lib.mean(array)
    end
    
    def standard_deviation(array)
      ::Mathstats::Lib.standard_deviation(array)
    end
    
    def median(array)
      sorted = array
      i = sorted.size % 2
      case i
       when 0 then sorted[i/2 - 1, 2].mean
       when 1 then sorted[i/2].to_f
      end if sorted.size > 0
    end
    
    module_function :mean, :standard_deviation, :median
    
  end
  
end