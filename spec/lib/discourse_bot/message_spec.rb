require 'spec_helper'

describe DiscourseBot::Message do
  let(:options) do
    {
      id: 1,
      text: 'An interesting message'
    }
  end
  subject(:message) { DiscourseBot::Message.new(options) }

  specify { expect(subject.id).to eq(1)  }
  specify { expect(subject.text).to eq('An interesting message')  }
  specify { expect(subject.path).to eq('/t/1')  }
end
