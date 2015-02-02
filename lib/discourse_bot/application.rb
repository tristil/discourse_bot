module DiscourseBot
  class Application
    attr_accessor :config_path,
                  :config,
                  :bot,
                  :discourse_client

    def_delegators :bot, :pending_messages

    def initialize(config_path: DEFAULT_CONFIG_PATH)
      self.config_path = config_path
    end

    def setup
      self.config = Config.new(config_path)
      config.load

      self.discourse_client = DiscourseClient.new(config: config)

      self.bot = Bot.new(config: config, discourse_client: discourse_client)
      bot.register(CheckNewPosts.new)
    end

    def fetch_messages
      bot.run_activities
      bot.add_messages
    end

    def post_tweets

    end
  end
end
