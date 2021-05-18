# frozen_string_literal: true

require "zeitwerk"
require "orbit_activities"
require_relative "pipedrive_orbit/version"

module PipedriveOrbit
  loader = Zeitwerk::Loader.new
  loader.tag = File.basename(__FILE__, ".rb")
  loader.push_dir(__dir__)
  loader.setup
end