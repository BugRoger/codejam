# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"


class KingdomRush 
  include CodeJam::Logging

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      levels = []
      input.shift.to_i.times do |j|
        levels << [*input.shift.chomp.split.map(&:to_i), 0]
      end

      info "============================== Case ##{i+1} ==========================="
      puts "Case ##{i+1}: #{play(levels)}"
      info "\n"
    end
  end

  def play(levels)
    earned = 0
    turns  = 0

    while has_more?(levels, earned) do
      turns += 1

      if index = two_star_index(levels, earned) 
        levels[index][2] = 2
        earned += 2
      elsif index = one_star_index(levels, earned)
        levels[index][2] += 1
        earned += 1
      end
    end

    return done?(levels) ? turns : "Too Bad"
  end

  def one_star_index(levels, earned) 
    indexes = []
    levels.each_with_index do |l, i|
      indexes << i if l[1] <= earned && l[2] == 1
    end
    return indexes[0] unless indexes.empty?
    
    indexes = []
    levels.each_with_index do |l, i|
      indexes << i if (l[0] <= earned && l[2] == 0) 
    end
    indexes.max{|i, j| levels[i][1] <=> levels[j][1]}
  end

  def two_star_index(levels, earned)
    levels.index {|l| l[1] <= earned && l[2] == 0 }
  end

  def done?(levels)
    !levels.index {|l| l[2] < 2} 
  end

  def has_more?(levels, earned)
    levels.index {|l| (l[0] <= earned && l[2] == 0) || (l[1] <= earned && l[2] < 2)}
  end

end
