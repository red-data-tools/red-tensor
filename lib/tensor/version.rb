module Tensor
  VERSION = "0.0.1"

  module Version
    numbers, TAG = VERSION.split("-", 2)
    MAJOR, MINOR, MICRO = numbers.split(".", 3).map(&:to_i)
    STRING = VERSION
  end
end
