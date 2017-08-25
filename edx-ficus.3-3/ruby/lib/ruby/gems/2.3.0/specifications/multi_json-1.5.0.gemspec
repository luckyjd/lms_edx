# -*- encoding: utf-8 -*-
# stub: multi_json 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "multi_json".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Bleigh".freeze, "Josh Kalderimis".freeze, "Erik Michaels-Ober".freeze]
  s.date = "2012-12-10"
  s.description = "A gem to provide easy switching between different JSON backends, including Oj, Yajl, the JSON gem (with C-extensions), the pure-Ruby JSON gem, and OkJson.".freeze
  s.email = ["michael@intridea.com".freeze, "josh.kalderimis@gmail.com".freeze, "sferik@gmail.com".freeze]
  s.extra_rdoc_files = ["LICENSE.md".freeze, "README.md".freeze]
  s.files = ["LICENSE.md".freeze, "README.md".freeze]
  s.homepage = "http://github.com/intridea/multi_json".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A gem to provide swappable JSON backends.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 3.9"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.6"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0.4"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_dependency(%q<rdoc>.freeze, [">= 3.9"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.6"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0.4"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0.9"])
    s.add_dependency(%q<rdoc>.freeze, [">= 3.9"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.6"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.4"])
  end
end
