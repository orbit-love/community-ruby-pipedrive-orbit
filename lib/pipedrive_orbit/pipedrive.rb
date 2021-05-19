# frozen_string_literal: true

require "active_support/time"

module PipedriveOrbit
    class Pipedrive
        def initialize(params = {})
            @orbit_api_key = params.fetch(:orbit_api_key)
            @orbit_workspace = params.fetch(:orbit_workspace)
            @pipedrive_api_key = params.fetch(:pipedrive_api_key)
            @pipedrive_url = params.fetch(:pipedrive_url)
        end

        def process_notes
            notes = get_notes

            notes["data"].each do |note|
                next if note["person"] == nil || note["organization"] == nil 
                
                PipedriveOrbit::Orbit.call(
                    type: "note",
                    data: {
                        note: note,
                        pipedrive_url: @pipedrive_url
                    },
                    orbit_workspace: @orbit_workspace,
                    orbit_api_key: @orbit_api_key                )
            end
        end

        def process_activities
            activities = get_activities

            return get_activities["error"] if get_activities["success"] == false
            return "No new activities in the past day!" if activities.nil?

            activities["data"].each do |activity|
                next if no_member_info(activity)

                PipedriveOrbit::Orbit.call(
                    type: "activity",
                    data: {
                        activity: activity,
                        pipedrive_url: @pipedrive_url
                    },
                    orbit_workspace: @orbit_workspace,
                    orbit_api_key: @orbit_api_key
                )
            end
        end

        def process_people_notes
            people = get_people

            return people["error"] if people["success"] == false
            return "No people found!" if people.nil?

            people["data"].each do |person|
                next if person["notes_count"] <= 0 || person["notes_count"].nil?

                notes = get_people_notes(person)

                return notes["error"] if notes["success"] == false
                return "No notes found!" if notes.nil?

                notes["data"].each do |note|
                    PipedriveOrbit::Orbit.call(
                        type: "person_note",
                        data: {
                            note: note,
                            pipedrive_url: @pipedrive_url
                        },
                        orbit_workspace: @orbit_workspace,
                        orbit_api_key: @orbit_api_key
                    )
                end
            end
        end

        def get_people
            url = URI("https://api.pipedrive.com/v1/persons")
            url.query = "api_token=#{@pipedrive_api_key}"
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            
            request = Net::HTTP::Get.new(url)

            response = https.request(request)

            response = JSON.parse(response.body)     
        end

        def get_people_notes(person)
            url = URI("https://api.pipedrive.com/v1/notes")
            url.query = "person_id=#{person["id"]}&sort=add_time DESC&api_token=#{@pipedrive_api_key}"
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            
            request = Net::HTTP::Get.new(url)

            response = https.request(request)

            response = JSON.parse(response.body)    
        end

        def get_activities
            url = URI("https://api.pipedrive.com/v1/activities")
            url.query = "user_id=0&start_date=#{create_start_date}&end_date=#{create_end_date}&api_token=#{@pipedrive_api_key}"
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            
            request = Net::HTTP::Get.new(url)

            response = https.request(request)

            response = JSON.parse(response.body)
        end

        def no_member_info(activity)
            return true if activity["person_name"].nil? && activity["attendees"].nil?

            false
        end

        def create_start_date
            date = Date.parse(Time.now.utc.to_date.to_s)-1.day
            date.strftime("%Y-%m-%d")
        end

        def create_end_date
            date = Date.parse(Time.now.utc.to_date.to_s)
            date.strftime("%Y-%m-%d")
        end

        def get_notes
            url = URI("https://api.pipedrive.com/v1/notes")
            url.query = "sort=add_time DESC&api_token=#{@pipedrive_api_key}"
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            
            request = Net::HTTP::Get.new(url)

            response = https.request(request)

            response = JSON.parse(response.body)
        end
    end
end