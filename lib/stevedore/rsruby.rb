require 'rsruby'
class Stevedore
  
  module RSRuby
    
    def rsruby
      @rsruby ||= ::RSRuby.instance
    end
    
    def mean
      rsruby.mean(self)
    end
    
    def standard_deviation
      rsruby.sd(self)
    end
    
    def median
      rsruby.median(self)
    end
    
    def self.rsruby
      @rsruby ||= ::RSRuby.instance
    end
    
    def self.power_test(args)
      delta, power, sig_level, sd = args[:delta], args[:power], args[:sig_level], args[:sd]
      if sd < 0.00007
        warn "Stddev is very small, which makes power.t.test sad. \nSetting stddev to 0.00007 so we can get this done."
        sd = 0.00007
      end
      rsruby.power_t_test( :delta => delta, :power => power, :sig_level => sig_level, :sd => sd)
    end
        
  end
  
end