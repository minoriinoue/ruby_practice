require "komaba/mini_star"

module Komaba

  module NormalSerializer

    module_function

    def serializable?(obj)
      true
    end

    def serialize(obj)
      Marshal.dump(obj)
    end

    def deserialize(str)
      Marshal.load(str)
    end

  end

end

