require 'spec_helper'

require 'tempfile'

describe 'Check for new posts' do
  let(:config) do
    {
      "url" => "http://forum.example.com",
      "api_username" => "username",
      "api_password" => "password",
      "api_key" => "api_key"
    }
  end
  let(:config_file) do
    Tempfile.new('config_file').tap do |file|
      file.write(JSON.dump(config))
      file.rewind
    end
  end

  before do
    stub_request(:get, %r{latest\.json\?api_key})
      .to_return(
        body: {
          'users' => [{ 'username' => 'johndoe' }],
          'topic_list' => {
            'topics' => [
              { "id" => 1,
                "title" => "A very interesting topic" },
              { "id" => 2,
                "title" => "Another interesting topic" }
            ]
          }
    }
    )
  end

  it 'collects data from input sources' do
    application = DiscourseBot::Application.new(config_path: config_file.path)
    application.setup

    application.fetch_messages

    first_message = application.pending_messages.first
    expect(first_message.text).to eq('A very interesting topic')
    expect(first_message.path).to eq('/t/1')
    second_message = application.pending_messages[1]
    expect(second_message.text).to eq('Another interesting topic')
    expect(second_message.path).to eq('/t/2')
  end

  it 'posts collected messages to Twitter' do
    application = DiscourseBot::Application.new(config_path: config_file.path)
    application.setup

    application.fetch_messages
    application.post_tweets
  end
end
