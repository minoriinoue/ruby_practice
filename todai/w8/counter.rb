class Counter
    attr_reader :counter
    def initialize
        @counter = 0
    end
    def increment
        @counter += 1
    end
end
