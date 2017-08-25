# -*- encoding: utf-8 -*-
# stub: akami 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "akami".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Harrington".freeze]
  s.date = "2012-06-28"
  s.description = "Building Web Service Security".freeze
  s.email = ["me@rubiii.com".freeze]
  s.homepage = "https://github.com/rubiii/akami".freeze
  s.rubyforge_project = "akami".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Web Service Security".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gyoku>.freeze, [">= 0.4.0"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.4.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.8.7"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.5.0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.3.5"])
      s.add_development_dependency(%q<autotest>.freeze, [">= 0"])
    else
      s.add_dependency(%q<gyoku>.freeze, [">= 0.4.0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.4.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.8.7"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.5.0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.3.5"])
      s.add_dependency(%q<autotest>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<gyoku>.freeze, [">= 0.4.0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.4.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.8.7"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.5.0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.3.5"])
    s.add_dependency(%q<autotest>.freeze, [">= 0"])
  end
end
