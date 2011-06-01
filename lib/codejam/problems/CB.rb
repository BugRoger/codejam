##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class CB < Problem 

    def prepare(input)
      @boosters, @time, @planets, c, *@cycle = input[0].split.map(&:to_i)
      
      @path = []
      @cycle.cycle((@planets.to_f / c).ceil) { |d| @path <<  d * 2 if @path.length < @planets}
    end 
      
    def solve
      debug "Unboosted: #{@path}"
      
      boostable = boostable_path(@path)
      # debug "Boostable: #{boostable}"
      
      savings   = savings_path(boostable)
      debug "Savings:   #{savings}"

      boosted   = subtract(@path, savings)
      debug  "Boosted:   #{boosted}"

      boosted.inject(0){|sum,x| sum + x } 
    end


    def subtract(a, b)
      dummy = a.dup

      b.each_with_index do |s, i|
        dummy[i] -= s
      end

      dummy
    end


    def savings_path(path)
      boostable = []
      path.each_with_index { |p, i| boostable << [p,i] }

      boostable.sort! { |a,b| b[0] - a[0] }

      savings   = Array.new(path.length, 0) 
      boostable.take(@boosters).each do |p|
        dist, index = p
        savings[index] = dist / 2
      end

      savings 
    end

    def boostable_path(path)
      prio = path.dup 
      unboosted = 0
      
      prio.each_with_index do |way, index|
        if (unboosted + way) < @time
          unboosted   += way
          prio[index] = 0 
        else
          remainder = @time - unboosted
          prio[index] -= remainder
          break
        end
      end


      prio
    end




  end

end
