# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erlang_config/version'

Gem::Specification.new do |spec|
  spec.name          = "erlang_config"
  spec.version       = ErlangConfig::VERSION
  spec.authors       = ["Roman Gaufman"]
  spec.email         = ["roman@xanview.com"]
  spec.summary       = %q{Encode and Decode Erlang style configuration files.}
  spec.description   = %q{See summery}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
end
