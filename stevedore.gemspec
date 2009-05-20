# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stevedore}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew King"]
  s.date = %q{2009-05-20}
  s.email = %q{self@automatthew.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
     "Rakefile",
     "VERSION",
     "examples/concat.rb",
     "examples/data.yml",
     "examples/instance_eval.rb",
     "examples/stats_libs.rb",
     "examples/variance.rb",
     "lib/stevedore.rb",
     "lib/stevedore/class.rb",
     "lib/stevedore/instance.rb",
     "lib/stevedore/rsruby.rb",
     "lib/stevedore/sample.rb",
     "lib/stevedore/shell_r.rb",
     "lib/stevedore/stats.rb",
     "test/helper.rb",
     "test/test_R.rb",
     "test/test_sample.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/automatthew/stevedore}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Benchmarking framework with some statistickal stuff}
  s.test_files = [
    "test/helper.rb",
     "test/test_R.rb",
     "test/test_sample.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruport>, [">= 0"])
    else
      s.add_dependency(%q<ruport>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruport>, [">= 0"])
  end
end
