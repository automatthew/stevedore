Version = '0.1.0'

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
  end
rescue
  "(ignored echoe gemification, as you don't have the Right Stuff)"
end