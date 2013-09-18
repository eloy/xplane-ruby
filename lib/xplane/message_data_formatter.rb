module Xplane::MessageDataFormater

  # Binary data formats
  #----------------------------------------------------------------------

  HEADER_FORMAT = "CCCCC"
  DATA_FORMAT = "iffffffff"

  DATA_ELEMENTS = 8


  # Read and parse data received from XPlane
  #----------------------------------------------------------------------

  def parse_binary_data(binary_data)
    chunk_size = DATA_ELEMENTS + 1 # plus header
    data_elements = binary_data.length / DATA_FORMAT.length
    data_format =  binary_format data_elements
    unpacked = binary_data.unpack(data_format)
    buffer = unpacked[HEADER_FORMAT.length..-1]
    data = {}
    data_elements.times do |element_index|
      offset = element_index * chunk_size
      chunk = buffer[offset..offset + chunk_size]
      element_id = chunk[0]
      map = Xplane::XPLANE_DATA_MAPPER[element_id]
      if map
        map.each_with_index do |key, i|
          data[key] = chunk[i + 1] # plus header
        end
      end
    end
    return data
  end

  # Create a DATA package with the given data
  def build_binary_data(data={})
    buffer = [68, 65, 84, 65, 0] # D A T A
    elements_to_send = []
    keys_to_send = data.keys

    Xplane::XPLANE_DATA_MAPPER.each do |element_id, included_elements|
     element = nil
      included_elements.each_with_index do |element_name, index|
        if keys_to_send.include? element_name
          element ||= new_element(element_id)
          element[index + 1] = data[element_name]
        end
      end
      elements_to_send.push element unless element.nil?
    end

    elements_to_send.each do |element|
      buffer += element
    end
    buffer.pack binary_format(elements_to_send.length)
  end

  private

  def binary_format(elements=1)
    HEADER_FORMAT + DATA_FORMAT * elements
  end

  # Build an empty element
  def new_element(element_id)
    e = [element_id]
    DATA_ELEMENTS.times do
      e.push -999 # Ignore
    end
    return e
  end

end
