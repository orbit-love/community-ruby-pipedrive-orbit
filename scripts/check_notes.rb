#!/usr/bin/env ruby
# frozen_string_literal: true

require "pipedrive_orbit"
require "thor"

module PipedriveOrbit
  module Scripts
    class CheckNotes < Thor
      desc "render", "check for new Pipedrive deal notes and push them to Orbit"
      def render
        client = PipedriveOrbit::Client.new
        client.notes
      end
    end
  end
end