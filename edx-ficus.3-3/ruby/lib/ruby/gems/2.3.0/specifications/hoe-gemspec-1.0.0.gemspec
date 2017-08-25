# -*- encoding: utf-8 -*-
# stub: hoe-gemspec 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-gemspec".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Dalessio".freeze]
  s.date = "2010-09-03"
  s.description = "Generate a prerelease gemspec based on a Hoe spec.".freeze
  s.email = ["mike.dalessio@gmail.com".freeze]
  s.extra_rdoc_files = ["Manifest.txt".freeze, "CHANGELOG.rdoc".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/flavorjones/hoe-gemspec".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubyforge_project = "hoe-gemspec".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Generate a prerelease gemspec based on a Hoe spec.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hoe>.freeze, [">= 2.2.0"])
      s.add_development_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe>.freeze, [">= 2.6.1"])
    else
      s.add_dependency(%q<hoe>.freeze, [">= 2.2.0"])
      s.add_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<hoe>.freeze, [">= 2.6.1"])
    end
  else
    s.add_dependency(%q<hoe>.freeze, [">= 2.2.0"])
    s.add_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<hoe>.freeze, [">= 2.6.1"])
  end
end
