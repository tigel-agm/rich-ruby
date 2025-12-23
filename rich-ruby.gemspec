# frozen_string_literal: true

require_relative "lib/rich/version"

Gem::Specification.new do |spec|
  spec.name          = "rich-ruby"
  spec.version       = Rich::VERSION
  spec.authors       = ["tigel-agm"]

  spec.summary       = "Rich terminal formatting for Ruby (Windows-native)"
  spec.description   = <<~DESC
    A pure Ruby implementation of rich terminal output with full Windows Console API 
    support via Fiddle. Features include styled text, tables, panels, progress bars,
    spinners, live display, syntax highlighting, and more. No external dependencies.
  DESC
  spec.homepage      = "https://github.com/tigel-agm/rich-ruby"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.4.0"

  spec.files = Dir.chdir(__dir__) do
    Dir["{lib,examples}/**/*", "LICENSE", "README.md"]
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rbs", "~> 3.0"

  spec.metadata = {
    "homepage_uri"       => spec.homepage,
    "source_code_uri"    => spec.homepage,
    "windows_compatible" => "true",
    "msvc_compatible"    => "true",
    "rubygems_mfa_required" => "true"
  }
end
