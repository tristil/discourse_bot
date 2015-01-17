module DiscourseBot
  class Bot
    attr_accessor :config,
                  :discourse_client,
                  :activities

    def initialize(config: nil, discourse_client: nil)
      self.config = config
      self.discourse_client = discourse_client
      self.activities = []
    end

    def register(activity)
      activity.bot = self
      self.activities << activity
    end

    def run
      activities.each(&:run)
    end
  end
end
