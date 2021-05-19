#!/usr/bin/env ruby
# frozen_string_literal: true

require "pipedrive_orbit"
require "thor"

module PipedriveOrbit
  module Scripts
    class CheckPeopleNotes < Thor
      desc "render", "check for new Pipedrive people notes and push them to Orbit"
      def render
        client = PipedriveOrbit::Client.new
        client.people_notes
      end
    end
  end
end