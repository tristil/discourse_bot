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
end
