class Xplane::Message
  include Xplane::MessageDataFormater

  def initialize(connection, binary_data = false)
    @conn = connection
    @data = parse_binary_data(binary_data) if binary_data
  end

  # Send data back to Xplane
  def send(data={})
    binary_data = build_binary_data data
    @conn.send_datagram binary_data, Xplane.config.xplane_host, Xplane.config.xplane_port
  end


  # Define getters
  #----------------------------------------------------------------------

  Xplane::XPLANE_DATA_MAPPER.values.each do |data_element|
    data_element.each do |key|
      define_method(key) do
        @data[key]
      end
    end
  end

end
