require 'rsruby'
class Stevedore
  
  module RSRuby
    
    def self.rsruby
      @rsruby ||= ::RSRuby.instance
    end
    
    def rsruby
      @rsruby ||= ::RSRuby.instance
    end
    
    def mean; rsruby.mean(self); end
    
    def standard_deviation; rsruby.sd(self); end
    
    def median; rsruby.median(self); end
    
    def self.power_test(args); rsruby.power_t_test( args ); end
        
  end
  
end