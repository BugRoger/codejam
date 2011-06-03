##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class PerfectHarmony < Problem 
    extend NLineSplitter

    def prepare(input)
      @n, @l, @h = input.shift.split.map(&:to_i)
      *@notes    = input.shift.split.map(&:to_i) 
    end 

    def solve
      @l.upto(@h) do |frequency|
        return frequency if @notes.all? { |note| frequency % note == 0 || note % frequency == 0}
      end

      "NO"
    end 
  end

end
