require 'spec_helper'

describe DiscourseBot::Bot do
  let(:bot) { DiscourseBot::Bot.new }
  let(:config) { instance_double(DiscourseBot::Config) }

  specify '#run_activities calls run on each activity' do
    activity1 = instance_double(DiscourseBot::Activity)
    activity2 = instance_double(DiscourseBot::Activity)
    bot.activities << activity1
    bot.activities << activity2
    expect(activity1).to receive(:run)
    expect(activity1).to receive(:process)
    expect(activity2).to receive(:run)
    expect(activity2).to receive(:process)
    bot.run_activities
  end

  specify '#add_messages appends messages from activities to messages' do
    activity1 = instance_double(DiscourseBot::Activity, messages: [:a, :b])
    activity2 = instance_double(DiscourseBot::Activity, messages: [:c, :d])
    bot.activities << activity1
    bot.activities << activity2
    bot.add_messages
    expect(bot.messages).to eq([:a, :b, :c, :d])
  end

  specify '#register adds the activity to the activities list' do
    bot.config = config
    activity1 = instance_double(DiscourseBot::Activity)
    allow(activity1).to receive(:bot=).with(bot)
    bot.register(activity1)
    expect(bot.activities).to eql([activity1])
  end
end
