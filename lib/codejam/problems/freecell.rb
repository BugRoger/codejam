module CodeJam
  class FreeCell < Problem
    def prepare(input)
      tokens = input.split

      @n  = tokens.shift.to_i
      @pd = tokens.shift.to_i
      @pg = tokens.shift.to_i
    end

    def solve(input)
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
