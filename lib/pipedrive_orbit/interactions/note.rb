# frozen_string_literal: true

require "json"

module PipedriveOrbit
  module Interactions
    class Note
      def initialize(note:, pipedrive_url:, orbit_workspace:, orbit_api_key:)
        @note = note
        @pipedrive_url = pipedrive_url
        @orbit_workspace = orbit_workspace
        @orbit_api_key = orbit_api_key

        after_initialize!
      end

      def after_initialize!
        OrbitActivities::Request.new(
            api_key: @orbit_api_key,
            workspace_id: @orbit_workspace,
            user_agent: "community-ruby-pipedrive-orbit/#{PipedriveOrbit::VERSION}",
            action: "new_activity",
            body: construct_body.to_json
        )
      end

      def construct_url
        return nil if @note["deal_id"].nil?

        if @pipedrive_url.end_with?("/")
            return "#{pipedrive_url}deal/#{@note["deal_id"]}"
        end

        "#{@pipedrive_url}/deal/#{@note["deal_id"]}"
      end

      def construct_name
        return @note["person"]["name"] if @note["person"]

        @note["organization"]["name"]
      end
      
      def construct_body
        hash = {
          activity: {
            activity_type: "pipedrive:note",
            tags: ["channel:pipedrive"],
            title: "Added Note to Pipedrive",
            description: construct_description,
            occurred_at: @note["add_time"],
            key: @note["id"],
            member: {
              name: construct_name
            }
          },
          identity: {
            source: "pipedrive",
            name: construct_name
          }
        }

        hash[:activity].merge!(link: construct_url) unless construct_url.nil? || construct_url == "" 
        hash[:activity][:member].merge!(company: @note["organization"]["name"]) if @note["organization"]

        hash
      end

      def construct_description
        note = @note["content"].dup

        note.prepend("Note added for deal - #{@note["deal"]["title"]}:<br>") unless @note["deal"] == nil

        note
      end
    end
  end
end