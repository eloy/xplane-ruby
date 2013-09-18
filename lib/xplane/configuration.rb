module Xplane
  class Configuration
    attr_accessor :xplane_host, :xplane_port, :listen_address, :listen_port
    def initialize
      xplane_host = "127.0.0.1"
      xplane_port = 49000
      listen_port = 49001
      listen_address = "127.0.0.1"
    end
  end
  @@config ||= Configuration.new

  def self.config(&block)
    block.call @@config if block
    return @@config
  end

end
