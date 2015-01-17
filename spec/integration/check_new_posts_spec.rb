require 'spec_helper'

require 'tempfile'

describe 'Check for new posts' do
  it 'checks' do
    VCR.use_cassette('check_for_new_posts') do
      DiscourseBot.run
    end
  end
end
