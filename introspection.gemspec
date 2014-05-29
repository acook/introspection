lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'introspection'
  gem.version       = '0.0.1'
  gem.authors       = ['Anthony Cook']
  gem.email         = ['anthonymichaelcook@gmail.com']
  gem.description   = %q{Makes digging deeper into Ruby objects easier.}
  gem.summary       = %q{A tool to examine your Ruby environment.}
  gem.homepage      = 'http://github.com/acook/introspection'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'open4'
end
