lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tensor/version"

Gem::Specification.new do |spec|
  spec.name = "tensor"
  version_components = [
    Tensor::Version::MAJOR.to_s,
    Tensor::Version::MINOR.to_s,
    Tensor::Version::MICRO.to_s,
    Tensor::Version::TAG
  ]
  spec.version = version_components.compact.join(".")
  spec.authors = ["mrkn"]
  spec.email = ["mrkn@mrkn.jp"]

  spec.summary = %q{Common protocol for numerical array libraries}
  spec.description = %q{Common protocol for numerical array libraries}
  spec.homepage = "https://github.com/red-data-tools/red-tensor.rb"
  spec.license = "MIT"

  spec.files = ["README.md", "Rakefile", "Gemfile", "#{spec.name}.gemspec"]
  spec.files << "LICENSE.txt"
  spec.files.concat Dir.glob("lib/**/*.rb")

  spec.test_files.concat Dir.glob("test/**/*.rb")

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
