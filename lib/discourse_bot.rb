$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'mail'
require 'capybara'
require 'discourse_api'
require 'delegate'
require 'forwardable'
require 'pry'

Capybara.default_driver = :selenium

class Object
  extend Forwardable
end

require 'discourse_bot/config'
require 'discourse_bot/discourse_client'
require 'discourse_bot/bot'
require 'discourse_bot/activity'
require 'discourse_bot/check_new_posts'
require 'discourse_bot/signups_checker'

module DiscourseBot
  DEFAULT_CONFIG_PATH = File.dirname(__FILE__) + '/../' +
    File::SEPARATOR + 'config.json'

  def self.run(config_path: DEFAULT_CONFIG_PATH)
    config = Config.new(config_path)
    config.load

    discourse_client = DiscourseClient.new(config: config)

    bot = Bot.new(config: config, discourse_client: discourse_client)

    bot.register(CheckNewPosts.new)

    bot.run
  end
end
