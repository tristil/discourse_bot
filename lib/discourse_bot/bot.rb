module DiscourseBot
  class Bot
    attr_accessor :config,
                  :discourse_client,
                  :activities,
                  :messages

    def initialize(config: nil, discourse_client: nil)
      self.config = config
      self.discourse_client = discourse_client
      self.activities = []
      self.messages = []
    end

    def register(activity)
      activity.bot = self
      self.activities << activity
    end

    def fetch_messages
      run_activities
      add_messages
    end

    def run_activities
      activities.each do |activity|
        activity.run
        activity.process
      end
    end

    def add_messages
      messages.concat(activities.flat_map(&:messages))
    end

    def pending_messages
      messages
    end
  end
end
