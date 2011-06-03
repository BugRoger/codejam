##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class SpaceEmergency < Problem 

    def prepare(input)
      @boosters, @build_time, @planets, @cycle_size, *@cycle = input[0].split.map(&:to_i)
    end 
      
    def solve
      unboosted_time - boosted_time
    end

    def each_planet
      0.upto(@planets - 1) do |i|
        yield @cycle[i % @cycle_size]
      end
    end
      
    def unboosted_time
      total = 0
      each_planet { |distance| total += distance }

      total * 2
    end

    def boosted_time
      total_time      = 0
      building        = true
      boostable_edges = [0]

      each_planet do |distance|
        total_time += distance * 2

        boostable_edges << distance unless building

        if building && total_time > @build_time
          boostable_edges << (total_time - @build_time) / 2
          building = false
        end
      end

      boostable_edges.sort!{ |a, b| b <=> a }.first(@boosters).inject(&:+) or 0
    end

  end
end
