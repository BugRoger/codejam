##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class FreeCell < Problem
    def prepare(input)
      @n, @pd, @pg = input[0].split.map(&:to_i)
    end

    def solve
      isPossiblePd? && isPossiblePg? ? "Possible" : "Broken"
    end

    def isPossiblePd?
      return true if @pd == 0 || @pd == 100

      gcd = @pd.gcd(100) 
      min_total_games = 100 / gcd

      min_total_games <= @n 
    end

    def isPossiblePg?
     return false if @pg == 100 && @pd < 100
     return false if @pg == 0   && @pd > 0
     true
    end
  end
end
