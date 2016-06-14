# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ninetynine_snakes/version'

Gem::Specification.new do |spec|
  spec.name          = "ninetynine_snakes"
  spec.version       = NinetynineSnakes::VERSION
  spec.authors       = ["Nico De Witte", "Sille Van Landschoot"]
  spec.email         = ["nico.dewitte@vives.be", "info@sillevl.be"]

  spec.summary       = %q{Multiplayer snake using gosu}
  spec.homepage      = "https://github.com/99-bugs/ninetynine_snakes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"

  spec.add_dependency "gosu", '0.10.6'
end
