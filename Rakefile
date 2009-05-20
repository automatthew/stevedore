begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "stevedore"
    s.summary = "Benchmarking framework with some statistickal stuff"
    s.email = "self@automatthew.com"
    s.homepage = "http://github.com/automatthew/stevedore"
    s.authors = ["Matthew King"]
    s.files =  FileList["[A-Z]*", "{bin,lib,examples,test}/**/*", 'lib/jeweler/templates/.gitignore']
    s.test_files = FileList["test/**/*.rb"].exclude("**/setup.rb")
    s.add_dependency 'ruport'
  end
rescue LoadError
  puts "Jeweler or a dep just isn't in your $:. Try `sudo gem install technicalpickles-jeweler`"
end

