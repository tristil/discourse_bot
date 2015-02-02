module DiscourseBot
  class CheckNewPosts < Activity
    def_delegator :discourse_client, :latest_topics

    def run
      self.results = latest_topics
    end

    def process
      self.messages = results.map do |topic|
        DiscourseBot::Message.new(
          id: topic['id'],
          text: topic['title'])
      end
    end
  end
end
