class Stevedore
    
  def sample_means
    @samples.map { |s| s.mean }
  end
  
  def sample_standard_deviations
    @samples.map { |s| Stats.standard_deviation s }
  end
  
  def mean
    Stats.mean( self.flattened_samples )
  end
  
  def standard_deviation
    Stats.standard_deviation( self.flattened_samples )
  end
  
  def median
    Stats.median( self.flattened_samples )
  end
  
  def min
    self.flattened_samples.min
  end
  
  def max
    self.flattened_samples.max
  end
  
end

