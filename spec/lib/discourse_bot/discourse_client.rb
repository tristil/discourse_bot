require 'spec_helper'

describe DiscourseBot::DiscourseClient do
  let(:config) do
    instance_double(DiscourseBot::Config,
                    url: 'url',
                    api_key: 'api_key',
                    api_username: 'api_username')
  end
  let(:discourse_client) { DiscourseBot::DiscourseClient.new(config: config) }
  let(:api_client) { instance_double(DiscourseApi::Client) }

  before do
    allow(DiscourseApi::Client).to receive(:new).with('url')
      .and_return(api_client)
    allow(api_client).to receive(:api_key=).with('api_key')
    allow(api_client).to receive(:api_username=).with('api_username')
  end

  specify 'client forwards its methods to DiscourseApi::Client' do
    expect(api_client).to receive(:latest_topics)
    discourse_client.latest_topics
  end
end
