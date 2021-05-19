#!/usr/bin/env ruby
# frozen_string_literal: true

require "pipedrive_orbit"
require "thor"

module PipedriveOrbit
  module Scripts
    class CheckActivities < Thor
      desc "render", "check for new Pipedrive activities and push them to Orbit"
      def render
        client = PipedriveOrbit::Client.new
        client.activities
      end
    end
  end
end