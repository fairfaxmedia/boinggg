# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boinggg/version'

Gem::Specification.new do |spec|
  spec.name          = "boinggg"
  spec.version       = Boinggg::VERSION
  spec.authors       = ["John Slee"]
  spec.email         = ["john.slee@fairfaxmedia.com.au"]

  spec.summary       = %q{Framework for testing HTTP redirects}
  spec.description   = %q{Framework for testing HTTP redirects. Uncomplicated. No excuses.}
  spec.homepage      = "https://github.com/fairfaxmedia/boinggg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "colorize"
  spec.add_runtime_dependency "differ"
  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
