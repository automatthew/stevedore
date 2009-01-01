require 'rubygems'

Version = '0.1.0'

task :default => [ :test ]

begin
  gem 'echoe', '~>3.0'
  require 'echoe'
  Echoe.new('stevedore', Version) do |p|
    p.project = 'stevedore'
    p.summary = "Benchmarking with a whiff of statistical awareness"
    p.author = "Matthew King"
    p.email = "automatthew@gmail.com"
    p.ignore_pattern = /^(\.git).+/
    p.test_pattern = "test/*.rb"
  end
rescue
  "(ignored echoe gemification, as you don't have the Right Stuff)"
end