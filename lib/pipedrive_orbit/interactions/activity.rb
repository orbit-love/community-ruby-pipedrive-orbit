# frozen_string_literal: true

require "json"

module PipedriveOrbit
  module Interactions
    class Activity
      def initialize(activity:, pipedrive_url:, orbit_workspace:, orbit_api_key:)
        @activity = activity
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
            body: construct_body.to_json
        )
      end

      def construct_member
        hash = { name: @activity["person_name"] } unless @activity["person_name"].nil?
        
        return hash unless hash.nil?
        
        if !@activity["attendees"].nil?
            hash = { email: @activity["attendees"][0]["email_address"] }
        end

        hash
      end
      
      def construct_body
        hash = {
          activity: {
            activity_type: "pipedrive:activity",
            tags: ["channel:pipedrive"],
            title: "Added New #{@activity["type"].capitalize} Activity to Pipedrive",
            description: construct_description,
            occurred_at: @activity["add_time"],
            key: @activity["id"],
            member: {}
          },
          identity: {
            source: "pipedrive"
          }
        }

        hash[:activity][:member].merge!(construct_member)
        hash[:activity][:member].merge!(company: @activity["org_name"]) unless @activity["org_name"].nil?
        hash[:identity].merge!(construct_member)

        hash
      end

      def construct_description
        if @activity["note"]
            return @activity["note"]
        end
        
        "#{@activity["subject"]} was added by #{@activity["owner_name"]}"
      end
    end
  end
end