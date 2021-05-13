# frozen_string_literal: true

require_relative "lib/pipedrive_orbit/version"

Gem::Specification.new do |spec|
  spec.name = "pipedrive_orbit"
  spec.version                = PipedriveOrbit::VERSION
  spec.authors                = ["Orbit DevRel", "Ben Greenberg"]
  spec.email                  = ["devrel@orbit.love"]

  spec.summary                = "Integrate Pipedrive CRM interactions into Orbit"
  spec.description            = "This gem brings in Pipedrive activities to your Orbit workspace"
  spec.homepage               = "https://github.com/orbit-love/community-ruby-pipedrive-orbit"
  spec.license                = "MIT"
  spec.required_ruby_version  = Gem::Requirement.new(">= 2.7.2")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/orbit-love/community-ruby-pipedrive-orbit/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir                 = "bin"
  spec.executables            = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths          = ["lib"]

  spec.add_dependency "http", "~> 4.4"
  spec.add_dependency "json", "~> 2.5"
  spec.add_dependency "zeitwerk", "~> 2.4"
  spec.add_dependency "thor", "~> 1.1"
  spec.add_dependency "dotenv", "~> 2.7"
  spec.add_dependency "orbit_activities", "~> 0.0.1"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "webmock", "~> 3.12"
end