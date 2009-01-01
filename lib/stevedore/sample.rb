class Stevedore
  
  class Sample < Array
    
    
    def flattened
      @flat ||= self.flatten
    end

    def mean
      Stats.mean( self.flattened )
    end

    def standard_deviation
      Stats.standard_deviation( self.flattened )
    end

    def median
      Stats.median( self.flattened )
    end

    def min
      self.flattened.min
    end

    def max
      self.flattened.max
    end
    
  end
  
end