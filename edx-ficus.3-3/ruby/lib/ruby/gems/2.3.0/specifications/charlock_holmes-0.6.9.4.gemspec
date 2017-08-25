# -*- encoding: utf-8 -*-
# stub: charlock_holmes 0.6.9.4 ruby lib
# stub: ext/charlock_holmes/extconf.rb

Gem::Specification.new do |s|
  s.name = "charlock_holmes".freeze
  s.version = "0.6.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brian Lopez".freeze, "Vicent Mart\u{ed}".freeze]
  s.date = "2013-04-03"
  s.email = "seniorlopez@gmail.com".freeze
  s.extensions = ["ext/charlock_holmes/extconf.rb".freeze]
  s.files = ["ext/charlock_holmes/extconf.rb".freeze]
  s.homepage = "http://github.com/brianmario/charlock_holmes".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Character encoding detection, brought to you by ICU".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0.7.5"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<chardet>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0.7.5"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<chardet>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0.7.5"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<chardet>.freeze, [">= 0"])
  end
end
