##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class CB < Problem 

    def prepare(input)
      @boosters, @build_time, @planets, @cycle_length, *@cycle = input[0].split.map(&:to_i)
    end 
      
    def solve
      total_time      = 0
      boostable       = false
      boostable_edges = []

      each_planet do |distance|
        total_time += distance * 2

        unless boostable and total_time > @build_time
          distance = (total_time - @build_time) / 2
          boostable = true
        end

        boostable_edges << distance 
      end

      total_time - boostable_edges.sort!.reverse!.first(@boosters).inject(&:+)
    end

    def each_planet
      0.upto(@planets - 1) do |i|
        yield @cycle[i % @cycle_length]
      end
    end

  end
end
