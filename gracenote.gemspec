# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gracenote/version'

Gem::Specification.new do |gem|
  gem.name          = "gracenote"
  gem.version       = Gracenote::VERSION
  gem.authors       = ["Adam Rogers"]
  gem.email         = ["adam@rodreegez.com"]
  gem.description   = %q{Ruby wrapper for the Gracenote web api}
  gem.summary       = %q{Ruby wrapper for the Gracenote web api}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"

  gem.add_dependency "multi_xml"
end
