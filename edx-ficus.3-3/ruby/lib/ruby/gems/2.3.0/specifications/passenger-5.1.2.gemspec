# -*- encoding: utf-8 -*-
# stub: passenger 5.1.2 ruby src/ruby_supportlib
# stub: src/helper-scripts/download_binaries/extconf.rb

Gem::Specification.new do |s|
  s.name = "passenger".freeze
  s.version = "5.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["src/ruby_supportlib".freeze]
  s.authors = ["Phusion - http://www.phusion.nl/".freeze]
  s.date = "2017-01-25"
  s.description = "A modern web server and application server for Ruby, Python and Node.js, optimized for performance, low memory usage and ease of use.".freeze
  s.email = "software-signing@phusion.nl".freeze
  s.executables = ["passenger".freeze, "passenger-install-apache2-module".freeze, "passenger-install-nginx-module".freeze, "passenger-config".freeze, "passenger-status".freeze, "passenger-memory-stats".freeze]
  s.extensions = ["src/helper-scripts/download_binaries/extconf.rb".freeze]
  s.files = ["bin/passenger".freeze, "bin/passenger-config".freeze, "bin/passenger-install-apache2-module".freeze, "bin/passenger-install-nginx-module".freeze, "bin/passenger-memory-stats".freeze, "bin/passenger-status".freeze, "src/helper-scripts/download_binaries/extconf.rb".freeze]
  s.homepage = "https://www.phusionpassenger.com/".freeze
  s.rubyforge_project = "passenger".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A fast and robust web server and application server for Ruby, Python and Node.js".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0.8.1"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0.8.1"])
      s.add_dependency(%q<rack>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0.8.1"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
  end
end
