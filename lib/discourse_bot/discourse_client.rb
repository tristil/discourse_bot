module DiscourseBot
  class DiscourseClient
    attr_accessor :config

    def_delegator :client, :latest_topics

    def initialize(config: nil)
      raise ArgumentError, 'config' unless config
      self.config = config
    end

    def client
      @client ||= initialize_client
    end

    private

    def initialize_client
      DiscourseApi::Client.new(config.url).tap do |instance|
        instance.api_key = config.api_key
        instance.api_username = config.api_username
      end
    end
  end
end
