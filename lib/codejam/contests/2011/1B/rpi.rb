##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class RPI < Problem
    extend MultiLineSplitter

    def prepare(input)
      input.shift
      @size = input.length

      @schedule = {}
      1.upto(@size) do |team|
        schedule = input[team-1].chomp
        @schedule[team] = schedule 
      end
      debug "Schedule: #{@schedule}"


      @wp   = {}
      @owp  = {}
      @oowp = {}


      1.upto(@size) do |team|
        @wp[team]  = calculate_wp(@schedule[team], -1)
      end
      debug "WP: " + @wp.inspect

       1.upto(@size) do |team|
        @owp[team] = calculate_owp(@schedule[team], team)
      end
      debug "OWP: " + @owp.inspect
      

      1.upto(@size) do |team|
        @oowp[team] = calculate_oowp(@schedule[team])
      end
      debug "OOWP: " + @oowp.inspect

      return input
    end


    def solve
      result = [] 

      1.upto(@size) do |team|
        rpi = 0.25 * @wp[team] + 0.5 * @owp[team] + 0.25 * @oowp[team]
        result << "%.12g" % rpi 
      end

      result
    end


    def calculate_wp(schedule, throwOutTeam) 
      total = 0
      won   = 0
      lost  = 0

      0.upto(schedule.length - 1) do |i|
        unless throwOutTeam == i+1
          result = schedule[i]

          total += 1 unless result == "."
          won   += 1 if result == "1"
          lost  += 1 if result == "0"
        end
      end

      wp = total == 0 ? 0 : won.to_f / total
      debug "calculate_wp(#{schedule}, #{throwOutTeam}) => total = #{total}, won = #{won}, lost = #{lost}, wp = #{wp}"


      wp
    end
    

    def calculate_owp(schedule, team)
      total  = 0
      sum_wp = 0

      0.upto(schedule.length - 1) do |i|
        result = schedule[i]

        total  += 1 unless result == "."
        sum_wp += calculate_wp(@schedule[i+1], team) if result == "1" || result == "0"
      end

      owp = total == 0 ? 0 : sum_wp / total
      debug "Schedule: #{schedule}, Team: #{team} => owp = #{owp}"

      owp 
    end

    def calculate_oowp(schedule)
      total   = 0
      sum_owp = 0

      0.upto(schedule.length - 1) do |i|
        result = schedule[i]

        total   += 1 unless result == "."
        sum_owp += @owp[i+1] if result == "1" || result == "0"
      end

      total == 0 ? 0 : sum_owp / total
    end

  end
end
