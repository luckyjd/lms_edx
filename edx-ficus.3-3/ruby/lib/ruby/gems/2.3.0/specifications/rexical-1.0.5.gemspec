# -*- encoding: utf-8 -*-
# stub: rexical 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rexical".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aaron Patterson".freeze]
  s.date = "2010-12-08"
  s.description = "Rexical is a lexical scanner generator.\nIt is written in Ruby itself, and generates Ruby program.\nIt is designed for use with Racc.".freeze
  s.email = ["aaronp@rubyforge.org".freeze]
  s.executables = ["rex".freeze]
  s.extra_rdoc_files = ["Manifest.txt".freeze, "CHANGELOG.rdoc".freeze, "DOCUMENTATION.en.rdoc".freeze, "DOCUMENTATION.ja.rdoc".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "DOCUMENTATION.en.rdoc".freeze, "DOCUMENTATION.ja.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "bin/rex".freeze]
  s.homepage = "http://github.com/tenderlove/rexical/tree/master".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubyforge_project = "ruby-rex".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Rexical is a lexical scanner generator".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>.freeze, [">= 2.6.2"])
    else
      s.add_dependency(%q<hoe>.freeze, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<hoe>.freeze, [">= 2.6.2"])
  end
end
