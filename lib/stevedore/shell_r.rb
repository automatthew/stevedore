class Stevedore
  class ShellR

    def self.path(val=nil)
      val ? @path = val : @path ||= `which R`.chomp
    end

    def path
      self.class.path
    end

    def command(expression)
      %Q{#{path} --slave -e '#{expression}'}
    end

    def execute(expression)
      command = command(expression)
      r = `#{command}`
    end

    def power_test(options)
      power, delta, sig_level, sd = options[:power], options[:delta], options[:sig_level], options[:sd]
      if options[:sd] < 0.00007
        warn "Stddev is very small, which makes power.t.test sad. \nSetting stddev to 0.00007 so we can get this done."
        options[:sd] = 0.00007
      end
      expression = %Q{power.t.test(power=#{power}, delta=#{delta}, sd=#{sd}, sig.level=#{sig_level})[]}
      parse(execute(expression))
    end

    def parse(r_output)
      attrs = r_output.scan( /\$([\w\-\.]+)\s+\[\d+\]\s+([\d\.\-e\+]+)/m )
      r = attrs.map { |k,v| [k, v.to_f]  }.flatten
      Hash[*r]
    end

  end
end
