module DiscourseBot
  class Activity
    attr_accessor :bot

    attr_reader :results

    def_delegators :@bot, :discourse_client, :config

    def run
      raise NotImplementedError
    end
  end
end
