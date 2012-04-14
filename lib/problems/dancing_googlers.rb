# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"

class Array
  def is_possible?
    (max - min) < 3
  end

  def is_special?
    (max - min) == 2
  end
end

class DancingGooglers 
  include CodeJam::Logging

  SCORES  = (0..10).to_a.repeated_combination(3).to_a.keep_if(&:is_possible?)
  NORMAL  = SCORES.reject(&:is_special?).group_by {|t| t.inject(&:+)}
  SPECIAL = SCORES.keep_if(&:is_special?).group_by {|t| t.inject(&:+)}

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      _, s, p, *t = input.shift.chomp.split.map(&:to_i)   
      puts "Case ##{i+1}: #{count_max_scores(s, p, t)}"
    end
  end

  def count_max_scores(s, p, t)
    normal_count  = 0
    special_count = 0

    t.each do |score|
      if NORMAL.fetch(score)[0].max >= p 
        normal_count += 1
      elsif score > 1 && score < 29 && SPECIAL.fetch(score)[0].max >= p 
        special_count += 1
      end
    end

    normal_count + [special_count, s].min
  end
end
