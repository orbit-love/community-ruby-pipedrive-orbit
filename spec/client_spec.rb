# frozen_string_literal: true

require "spec_helper"

RSpec.describe PipedriveOrbit::Client do
  let(:subject) do
    PipedriveOrbit::Client.new(
      orbit_api_key: "12345",
      orbit_workspace: "test",
      pipedrive_api_key: "1234",
      pipedrive_url: "https://example.com"
    )
  end

  it "initializes with arguments passed in directly" do
    expect(subject).to be_truthy
  end

  it "initializes with credentials from environment variables" do
    allow(ENV).to receive(:[]).with("ORBIT_API_KEY").and_return("12345")
    allow(ENV).to receive(:[]).with("ORBIT_WORKSPACE").and_return("test")
    allow(ENV).to receive(:[]).with("PIPEDRIVE_API_KEY").and_return("1234")
    allow(ENV).to receive(:[]).with("PIPEDRIVE_URL").and_return("https://example.com")

    expect(PipedriveOrbit::Client).to be_truthy
  end
end