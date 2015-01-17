module DiscourseBot
  class CheckNewPosts < Activity
    def_delegator :discourse_client, :latest_topics

    def run
      @results = latest_topics
    end
  end
end
