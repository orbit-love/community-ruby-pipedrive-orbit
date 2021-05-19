# frozen_string_literal: true

require "spec_helper"


RSpec.describe PipedriveOrbit::Interactions::Activity do
  let(:subject) do
    PipedriveOrbit::Interactions::Activity.new(
      activity: {
        "id" => "82",
        "user_id" => "12301519",
        "deal_id" => "1234",
        "person_id" => "123",
        "org_id" => "444",
        "type" => "email",
        "person_name" => "Testing Person",
        "add_time" => "2021-05-18 05:11:52",
        "note" => "Testing note"
      },
      pipedrive_url: "https://example.com",
      orbit_workspace: "1234",
      orbit_api_key: "12345",

    )
  end

  describe "#call" do
    context "when the type is a note" do
      it "returns a Activity Object" do
        stub_request(:post, "https://app.orbit.love/api/v1/1234/activities")
          .with(
            headers: { 'Authorization' => "Bearer 12345", 'Content-Type' => 'application/json', 'User-Agent'=>"community-ruby-pipedrive-orbit/#{PipedriveOrbit::VERSION}" },
            body: "{\"activity\":{\"activity_type\":\"pipedrive:activity\",\"tags\":[\"channel:pipedrive\"],\"title\":\"Added New Email Activity to Pipedrive\",\"description\":\"Testing note\",\"occurred_at\":\"2021-05-18 05:11:52\",\"key\":\"82\",\"member\":{\"name\":\"Testing Person\"}},\"identity\":{\"source\":\"pipedrive\",\"name\":\"Testing Person\"}}"
          )
          .to_return(
            status: 200,
            body: {
              response: {
                code: 'SUCCESS'
              }
            }.to_json.to_s
          )

        content = subject.construct_body

        expect(content[:activity][:key]).to eql("82")
      end
    end
  end
end