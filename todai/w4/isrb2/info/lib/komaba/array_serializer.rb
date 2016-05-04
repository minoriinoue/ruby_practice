require "benchmark"

module Komaba

  module ArraySerializer

    module_function

    def serializable?(obj)
      obj.kind_of?(Array)
    end

    def serialize(obj)
      array = ["as"]
      format = "a2"
      case dimension = dimension(obj)
      when 1
        array << 1
        format << "C"
        array << obj.size
        format << "S"
      when 2
        array << 2
        format << "C"
        array << obj.size
        array << obj[0].size
        format << "S2"
      when 3
        array << 3
        format << "C"
        array << obj.size
        array << obj[0].size
        array << obj[0][0].size
        format << "S3"
      when 0
        raise ArgumentError, "not array"
      when Integer
        raise ArgumentError, "too many dimensions array"
      else
        raise "komaba bug"
      end
      if obj.kind_of?(Array)
        unless regular?(obj)
          message = ["irregular array!", "dimension: #{dimension}", "content:"]
          case dimension
          when 2
            message << "(index): [][]..."
            obj.each_with_index do |r, i|
              message << "  #{i}: #{'[]' * r.size}"
            end
          when 3
            message << "(index): [size][size]..."
            obj.each_with_index do |r, i|
              case r
              when Array
                message << "  #{i}: " + r.map do |r2|
                  case r2
                  when Array
                    "[#{r2.size}]"
                  else
                    "[(not array)]"
                  end
                end.join("")
              else
                message << "  #{i}: (not array)"
              end
            end
          else
            raise "komaba bug"
          end
          raise ArgumentError, message.join("\n")
        end
        objs = obj.flatten
        case dimension
        when 3
          ((objs.size + 1) / 2).times do |i|
            val1 = [[((objs[2 * i].to_f     || 0) * 0xf).to_i, 0].max, 0xf].min
            val2 = [[((objs[2 * i + 1].to_f || 0) * 0xf).to_i, 0].max, 0xf].min
            array << ((val2 << 4) | val1)
          end
        else
          objs.each do |o|
            array << [[((o.to_f || 0) * 0xff).to_i, 0].max, 0xff].min
          end
        end
        format << "C*"
        array.pack(format)
      else
        nil
      end
    end

    def deserialize(str)
      if str.unpack("a2") == ["as"]
        dimension = str.unpack("x2C").first
        sizes = str.unpack("x3S#{dimension}")
        values = str.unpack("x#{3 + dimension * 2}C*")
        case dimension
        when 1
          #i = 0
          Array.new(sizes[0]) do |i|
            values[i] / 255.0
          end
        when 2
          i = 0
          Array.new(sizes[0]) do
            Array.new(sizes[1]) do
              val = values[i] / 255.0
              i += 1
              val
            end
          end
        when 3
          i = 0
          Array.new(sizes[0]) do
            Array.new(sizes[1]) do
              Array.new(sizes[2]) do
                if i % 2 == 0
                  val = ((values[i / 2] || 0) & 15) / 15.0
                else
                  val = ((values[i / 2] || 0) >> 4) / 15.0
                end
                i += 1
                val
              end
            end
          end
        else
          raise ArgumentError, "invalid dimension #{dimension}"
        end
      else
        raise ArgumentError, "invalid format"
      end
    end

    def dimension(obj, level = 0)
      if 10 <= level
        raise SystemStackError, "too many dimensions (recursive array?)"
      end
      case obj
      when Array
        1 + (obj.map{|e| dimension(e, level + 1)}.max || 0)
      else
        0
      end
    end

    def regular?(obj)
      case obj
      when Array
        case head = obj[0]
        when Array
          head_dimension = dimension(head)
          head_size = head.size
          obj.all?{|e| e.class == Array and regular?(e) and dimension(e) == head_dimension and e.size == head_size}
        else
          obj.all?{|e| e.class != Array}
        end
      else
        true
      end
    end

  end

end
