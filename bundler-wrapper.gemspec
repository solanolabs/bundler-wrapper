# Copyright (c) 2015 Solano Labs All Rights Reserved

require "./lib/bundler-wrapper/version"

Gem::Specification.new do |s|
  s.name        = "bundler-wrapper"
  s.version     = Solano::VERSION
  s.platform    = (RUBY_PLATFORM == 'java' ? RUBY_PLATFORM : Gem::Platform::RUBY)
  s.authors     = ["Solano Labs"]
  s.email       = ["info@solanolabs.com"]
  s.homepage    = "https://github.com/solanolabs/solano.git"
  s.summary     = "Wrap bundler CLI for robustness"
  s.license     = "MIT"
  s.description = <<-EOF
Pending upstream fixes, wrap bundler command for robustness.
EOF

  s.files         = `git ls-files lib bin`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency("bundler", "~> 0.0", ">= 1.5.0")

  s.add_development_dependency("rspec", "~> 3.1")
  s.add_development_dependency("rake", "~> 10.4")
end
