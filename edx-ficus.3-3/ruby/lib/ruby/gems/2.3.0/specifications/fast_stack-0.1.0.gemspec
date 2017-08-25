# -*- encoding: utf-8 -*-
# stub: fast_stack 0.1.0 ruby lib
# stub: ext/fast_stack/extconf.rb

Gem::Specification.new do |s|
  s.name = "fast_stack".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Saffron".freeze]
  s.date = "2013-09-17"
  s.description = "Fast method for collecting stack traces in Ruby 2.1".freeze
  s.email = "sam.saffron@gmail.com".freeze
  s.extensions = ["ext/fast_stack/extconf.rb".freeze]
  s.files = ["ext/fast_stack/extconf.rb".freeze]
  s.homepage = "https://github.com/SamSaffron/fast_stack".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Fast method for collecting stack traces in Ruby 2.1".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
