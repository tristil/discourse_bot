require 'spec_helper'

describe DiscourseBot::Application do
  let(:application) { DiscourseBot::Application.new }

  specify '#setup loads the requisite components' do
    config = instance_double(DiscourseBot::Config)

    expect(DiscourseBot::Config)
      .to receive(:new)
      .with('/tmp/foo.json')
      .and_return(config)
    expect(config).to receive(:load)

    discourse_client = instance_double(DiscourseBot::DiscourseClient)

    expect(DiscourseBot::DiscourseClient)
      .to receive(:new)
      .with(config: config)
      .and_return(discourse_client)

    bot = instance_double(DiscourseBot::Bot)

    expect(DiscourseBot::Bot)
      .to receive(:new)
      .with(config: config, discourse_client: discourse_client)
      .and_return(bot)

    expect(bot)
      .to receive(:register)
      .with(an_instance_of(DiscourseBot::CheckNewPosts))

    DiscourseBot::Application.new(config_path: '/tmp/foo.json').setup
  end
end
