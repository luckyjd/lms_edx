# -*- encoding: utf-8 -*-
# stub: hiredis 0.4.5 ruby lib
# stub: ext/hiredis_ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "hiredis".freeze
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pieter Noordhuis".freeze]
  s.date = "2012-03-19"
  s.description = "Ruby extension that wraps Hiredis (blocking connection and reply parsing)".freeze
  s.email = ["pcnoordhuis@gmail.com".freeze]
  s.extensions = ["ext/hiredis_ext/extconf.rb".freeze]
  s.files = ["ext/hiredis_ext/extconf.rb".freeze]
  s.homepage = "http://github.com/pietern/hiredis-rb".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby extension that wraps Hiredis (blocking connection and reply parsing)".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 0.7.1"])
    else
      s.add_dependency(%q<rake-compiler>.freeze, ["~> 0.7.1"])
    end
  else
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 0.7.1"])
  end
end
