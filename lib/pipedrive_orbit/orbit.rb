# frozen_string_literal: true

module PipedriveOrbit
    class Orbit
      def self.call(type:, data:, orbit_workspace:, orbit_api_key:)
        if type == "note"
          PipedriveOrbit::Interactions::Note.new(
            note: data[:note],
            pipedrive_url: data[:pipedrive_url],
            orbit_workspace: orbit_workspace,
            orbit_api_key: orbit_api_key
          )
        end
      end
    end
  end