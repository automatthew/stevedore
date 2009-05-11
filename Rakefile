Version = '0.2.0'

task :default => [ :test ]

begin
  gem 'echoe', '~>3.0'
  require 'echoe'
  Echoe.new('stevedore', Version) do |p|
    p.project = 'stevedore'
    p.summary = "Benchmarking framework with some statistickal stuff"
    p.author = "Matthew King"
    p.email = "self@automatthew.com"
    p.ignore_pattern = /^(\.git).+/
    p.test_pattern = "test/*.rb"
    p.runtime_dependencies = ["ruport"]
  end
rescue LoadError
  puts "(ignored echoe gemification, as you don't have the Right Stuff)"
end


