module DiscourseBot
  class Message
    attr_accessor :text,
                  :id

    def initialize(**options)
      self.id = options.fetch(:id)
      self.text = options.fetch(:text)
    end

    def path
      "/t/#{id}"
    end
  end
end
