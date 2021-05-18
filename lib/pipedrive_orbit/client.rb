# frozen_string_literal: true

require "dotenv/load"
require "net/http"
require "json"

# Create a client to log Pipedrive activities and notes in your Orbit workspace
# Credentials can either be passed in to the instance or be loaded
# from environment variables
#
# @example
#   client = PipedriveOrbit::Client.new
#
# @option params [String] :orbit_api_key
#   The API key for the Orbit API
#
# @option params [String] :orbit_workspace
#   The workspace ID for the Orbit workspace
#
# @option params [String] :pipedrive_api_key
#   The token obtained after authenticating with LinkedIn
#   Required if value not provided for Pipedrive API key environment variable
#
# @option params [String] :pipedrive_url
#   The Pipedrive organization website URL
#
# @param [Hash] params
#
# @return [PipedriveOrbit::Client]
#
module PipedriveOrbit
  class Client
    attr_accessor :orbit_api_key, :orbit_workspace, :pipedrive_api_key, :pipedrive_url

    def initialize(params = {})
      @orbit_api_key = params.fetch(:orbit_api_key, ENV["ORBIT_API_KEY"])
      @orbit_workspace = params.fetch(:orbit_workspace, ENV["ORBIT_WORKSPACE_ID"])
      @pipedrive_api_key = params.fetch(:pipedrive_api_key, ENV["PIPEDRIVE_API_KEY"])
      @pipedrive_url = params.fetch(:pipedrive_url, ENV["PIPEDRIVE_URL"])
    end

    def notes
      PipedriveOrbit::Pipedrive.new(
        pipedrive_api_key: @pipedrive_api_key,
        pipedrive_url: @pipedrive_url,
        orbit_api_key: @orbit_api_key,
        orbit_workspace: @orbit_workspace
      ).process_notes
    end
  end
end