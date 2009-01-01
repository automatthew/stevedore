# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stevedore}
  s.version = "0.1.0"


  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew King"]
  s.date = %q{2009-01-01}
  s.description = %q{Benchmarking with a whiff of statistical awareness}
  s.email = %q{automatthew@gmail.com}
  s.extra_rdoc_files = ["lib/stevedore/class.rb", "lib/stevedore/instance.rb", "lib/stevedore/rsruby.rb", "lib/stevedore/shell_r.rb", "lib/stevedore/stats.rb", "lib/stevedore.rb", "README"]
  s.files = ["examples/data.yml", "examples/instance_eval.rb", "examples/stats_libs.rb", "lib/stevedore/class.rb", "lib/stevedore/instance.rb", "lib/stevedore/rsruby.rb", "lib/stevedore/shell_r.rb", "lib/stevedore/stats.rb", "lib/stevedore.rb", "Manifest", "Rakefile", "README", "stevedore.gemspec", "test/helper.rb", "test/test_R.rb", "test/test_sample.rb"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Stevedore", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{stevedore}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Benchmarking with a whiff of statistical awareness}
  s.test_files = ["test/helper.rb", "test/test_R.rb", "test/test_sample.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
