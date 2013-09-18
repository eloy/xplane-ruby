module Xplane

  class XplaneConnection < EventMachine::Connection
    def initialize(block)
      @block = block
    end

    def receive_data(binary_data)
      message = Message.new self, binary_data
      @block.call message
    end
  end

end
