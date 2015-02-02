require_relative 'lib/discourse_bot'

if __FILE__ == $0
  application = DiscourseBot::Application.new
  application.setup
  application.fetch_messages
  puts application.pending_messages
end
