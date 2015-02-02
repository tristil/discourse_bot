module DiscourseBot
  class Config
    attr_accessor :filename

    attr_accessor :data

    def initialize(filename)
      self.data = {}
      self.filename = filename
    end

    def api_username
      data['api_username']
    end

    def password
      data['api_password']
    end

    def api_key
      data['api_key']
    end

    def url
      data['url']
    end

    def load
      self.data = JSON.load(File.read(filename).strip)
      raise 'Incorrectly formatted JSON config file' unless @data
    end
  end
end
