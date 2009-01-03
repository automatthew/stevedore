class Stevedore
  
  begin
    require 'stevedore/rsruby'
    Stats = Stevedore::RSRuby
    puts "Stevedore will use RSRuby"
  rescue
    gem "bmarini-mathstats"
    require 'mathstats'
    Stats = Mathstats
    module Stats
      unless defined?(median)
        def median
          sorted = self.sort; i = sorted.size % 2
          case i
           when 0 then sorted[i/2 - 1, 2].mean
           when 1 then sorted[i/2].to_f
          end if sorted.size > 0
        end
      end
      def self.power_test(*args)
        Stevedore::ShellR.new.power_test(*args)
      end
    end
    puts "Stevedore will use Mathstats"
  end

  Array.send :include, Stats
  
end

