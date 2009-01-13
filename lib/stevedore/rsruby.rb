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
      if args[:sd] < 0.00007
        warn "Stddev is very small, which makes power.t.test sad. \nSetting stddev to 0.00007 so we can get this done."
        args[:sd] = 0.00007
      end
      rsruby.power_t_test( args )
    end
        
  end
  
end