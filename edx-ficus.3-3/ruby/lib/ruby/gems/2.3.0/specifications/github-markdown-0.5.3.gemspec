# -*- encoding: utf-8 -*-
# stub: github-markdown 0.5.3 ruby lib
# stub: ext/markdown/extconf.rb

Gem::Specification.new do |s|
  s.name = "github-markdown".freeze
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["GitHub, Inc".freeze]
  s.date = "2012-07-07"
  s.description = "Self-contained Markdown parser for GitHub, with all our custom extensions".freeze
  s.email = "vicent@github.com".freeze
  s.extensions = ["ext/markdown/extconf.rb".freeze]
  s.files = ["ext/markdown/extconf.rb".freeze]
  s.homepage = "http://github.github.com/github-flavored-markdown/".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "The Markdown parser for GitHub.com".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
  end
end
