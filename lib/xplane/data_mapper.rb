module Xplane
  XPLANE_DATA_MAPPER = {
    17 => [:pitch, :roll, :heading, :magnetic_heading],
    20 => [:lattitude, :longitude, :alt, :alt_agl],
    25 => [:throttle_cmd_1, :throttle_cmd_2, :throttle_cmd_3, :throttle_cmd_4 ],
    26 => [:throttle_1, :throttle_2, :throttle_3, :throttle_4 ]
  }
end
