require 'spec_helper'

describe DiscourseBot::CheckNewPosts do
  let(:activity) { DiscourseBot::CheckNewPosts.new }
  let(:config) { instance_double(DiscourseBot::Config, url: '') }
  let(:client) do
    object_double(DiscourseBot::DiscourseClient.new(config: config))
  end
  let(:bot) { instance_double(DiscourseBot::Bot, discourse_client: client) }

  describe '#run' do
    it 'fetches the new topics' do
      expect(client).to receive(:latest_topics).and_return('results')
      activity.bot = bot
      activity.run

      expect(activity.results).to eql('results')
    end
  end

  describe '#process' do
    let(:response_json) do
      [{ 'id' => 1, 'title' => :a },
       { 'id' => 2, 'title' => :b }]
    end

    it 'turns the results array of hashes into message objects' do
      message1 = instance_double(DiscourseBot::Message)
      message2 = instance_double(DiscourseBot::Message)
      expect(DiscourseBot::Message).to receive(:new)
        .with(id: 1, text: :a)
        .and_return(message1)
      expect(DiscourseBot::Message).to receive(:new)
        .with(id: 2, text: :b)
        .and_return(message2)

      activity.results = response_json
      activity.process

      expect(activity.messages).to eq([message1, message2])
    end
  end
end
