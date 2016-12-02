# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'introspect/version'

Gem::Specification.new do |gem|
  gem.name          = 'introspect'
  gem.version       = Introspect::VERSION
  gem.authors       = ['Anthony Cook']
  gem.email         = ['github@anthonymcook.com']
  gem.description   = %q{Makes digging deeper into Ruby objects easier.}
  gem.summary       = %q{A tool to examine your Ruby environment.}
  gem.homepage      = 'http://github.com/acook/introspect'

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.bindir        = 'bin'
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'open4'
end
