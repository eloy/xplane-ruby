require 'socket'
require 'eventmachine'
require 'xplane/configuration'
require 'xplane/data_mapper'
require 'xplane/message_data_formatter'
require 'xplane/message'
require 'xplane/connection'
require "xplane/version"

module Xplane

  def self.on_data_received(&block)
    listen_address = Xplane.config.listen_address
    port = Xplane.config.listen_port
    EM.run do
      EM.open_datagram_socket(listen_address, port, XplaneConnection, block)
    end
  end

end
