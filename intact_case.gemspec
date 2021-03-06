# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intact_case/version'

Gem::Specification.new do |spec|
  spec.name          = "intact_case"
  spec.version       = IntactCase::VERSION
  spec.authors       = ["Stew Eucen"]
  spec.email         = ["stew.eucen@gmail.com"]

  spec.summary       = %q{Reversible convertor for camelCase and snake_case which has acronyms.}
  spec.description   = %q{When camelCase has acronyms, can convert it to snake_case, however it can not be converted to original camelCase with intact acronyms. Rules of Intact Case is the solution for this problem.}
  spec.homepage      = "http://lab.kochlein.com/IntactCase"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  raise "RubyGems 2.0 or newer is required to protect against public gem pushes." \
      unless spec.respond_to?(:metadata)

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
