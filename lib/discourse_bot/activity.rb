module DiscourseBot
  class Activity
    attr_accessor :bot,
                  :messages,
                  :results

    def_delegators :@bot, :discourse_client, :config

    def initialize
      self.messages = []
    end

    def run
      raise NotImplementedError
    end

    def process
      raise NotImplementedError
    end
  end
end
