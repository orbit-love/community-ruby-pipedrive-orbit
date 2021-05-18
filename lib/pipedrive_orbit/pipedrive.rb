# frozen_string_literal: true

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