# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongo_grid/version'

Gem::Specification.new do |spec|
  spec.name          = "mongo_grid"
  spec.version       = MongoGrid::VERSION
  spec.authors       = ["zxy"]
  spec.email         = ["zxy@qq.com"]

  spec.summary       = %q{a file upload gem for rails using mongodb}
  spec.description   = %q{file upload to mongodb}
  spec.homepage      = "https://rubygems.org/lajunta/mongo_grid"
  spec.licenses      = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

end
