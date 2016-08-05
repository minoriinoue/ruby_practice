load './pqueue.rb'

class Track
    attr_accessor :location
    def initialize(gasoline)
        @gasoline = gasoline
        @gas_stand_available = PQueueLarger.new
        @gas_stand_used = []
        @location = 0
    end

    def run(distance)
        @gasoline = @gasoline - distance * 1
        @location = @location + distance
    end

    def gasoline_right_provided(gasoline)
        @gas_stand_available.push(gasoline)
    end

    def check_gasoline_necessary
        return true if @gasoline < 0
        return false
    end

    def consume_gasoline
        gasoline = @gas_stand_available.pop
        if gasoline == nil
            return false
        else
            @gasoline += gasoline
            @gas_stand_used << gasoline
            return true
        end
    end

    def count_gas_stand_used
        return @gas_stand_used.count
    end

    def show_gas_station_used
        return @gas_stand_used
    end
end

# if_goal_reachable returns the minimum frequency of the gas stands the track used
# when the track can reach the goal. If the track cannot get to the goal, the method
# returns -1.
def if_goal_reachable(num_gas_stand, course_distance, init_gas_amount, gas_stand_spot, gas_amounts)
    track = Track.new(init_gas_amount)
    gas_stand_spot.each_with_index do |dist, index|
        print "index: #{index}, dist: #{dist}\n"
        track.run(dist - track.location)
        while track.check_gasoline_necessary
            if_successful = track.consume_gasoline
            print "gasoline_necessary. consume gasoline_successful? #{if_successful}\n"
            return -1 unless if_successful
        end
        track.gasoline_right_provided(gas_amounts[index])
    end

    # From last gas stop to the goal
    track.run(course_distance - track.location)
    if track.check_gasoline_necessary
        if_successful = track.consume_gasoline
        return -1 unless if_successful
    end
    print "gas_station_used: #{track.show_gas_station_used}\n"
    return track.count_gas_stand_used
end

n = 4
l = 25
p = 10
a = [10, 14, 20, 21]
b = [10, 5, 2, 4]
puts if_goal_reachable(n, l, p, a, b)
