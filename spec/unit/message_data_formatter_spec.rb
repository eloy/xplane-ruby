require 'spec_helper'

class Formatter
  include Xplane::MessageDataFormater
end

describe Xplane::MessageDataFormater do
  let(:formatter) { Formatter.new }

  describe 'MessageDataFormater#build_binary_data' do
    it 'should create a binary message from the given binary data' do
      binary_data = formatter.build_binary_data(throttle_cmd_1: 1.1)
      data = formatter.parse_binary_data(binary_data)
      expect(data[:throttle_cmd_1].round(1)).to eq 1.1
    end
  end
end
