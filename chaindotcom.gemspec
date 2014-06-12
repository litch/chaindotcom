# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chaindotcom/version'

Gem::Specification.new do |spec|
  spec.name          = "chaindotcom"
  spec.version       = Chaindotcom::VERSION
  spec.authors       = ["Justin Litchfield"]
  spec.email         = ["j@obsidianexchange.com"]
  spec.summary       = %q{Ruby client gem for the Chain.com api}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   << 'chaindotcom'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 0.9.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'dotenv'
end
