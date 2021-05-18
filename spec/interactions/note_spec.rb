# frozen_string_literal: true

require "spec_helper"


RSpec.describe PipedriveOrbit::Interactions::Note do
  let(:subject) do
    PipedriveOrbit::Interactions::Note.new(
      note: {
        "id" => "82",
        "user_id" => "12301519",
        "deal_id" => "1234",
        "person_id" => "123",
        "org_id" => "444",
        "content" => "Test note",
        "add_time" => "2021-05-18 05:11:52",
        "organization" => {
            "name" => "Testing Org"
        },
        "person" => {
            "name" => "Testing Person"
        },
        "deal" => {
            "title" => "Testing Deal"
        }
      },
      pipedrive_url: "https://example.com",
      orbit_workspace: "1234",
      orbit_api_key: "12345",

    )
  end

  describe "#call" do
    context "when the type is a note" do
      it "returns a Note Object" do
        stub_request(:post, "https://app.orbit.love/api/v1/1234/activities")
          .with(
            headers: { 'Authorization' => "Bearer 12345", 'Content-Type' => 'application/json', 'User-Agent'=>"community-ruby-pipedrive-orbit/#{PipedriveOrbit::VERSION}" },
            body: "{\"activity\":{\"activity_type\":\"pipedrive:note\",\"tags\":[\"channel:pipedrive\"],\"title\":\"Added Note to Pipedrive\",\"description\":\"Note added for deal - Testing Deal:<br>Test note\",\"occurred_at\":\"2021-05-18 05:11:52\",\"key\":\"82\",\"member\":{\"name\":\"Testing Person\",\"company\":\"Testing Org\"},\"link\":\"https://example.com/deal/1234\"},\"identity\":{\"source\":\"pipedrive\",\"name\":\"Testing Person\"}}"
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