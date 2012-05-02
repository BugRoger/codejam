# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"

class PasswordProblem 
  include CodeJam::Logging

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      info i
      a, b = input.shift.chomp.split.map(&:to_i)
      *p   = input.shift.chomp.split.map(&:to_f)
      puts "Case ##{i+1}: #{solve(a, b, p)}"
    end
  end

  def solve(a, b, p)
    finish_correct   = b - a + 1
    finish_incorrect = b - a + 1 + b + 1
    p_finish_correct = p.inject(&:*)
    finish_expected  = p_finish_correct * finish_correct + (1 - p_finish_correct)  * finish_incorrect
    min = finish_expected

    give_up_expected = 1 + b + 1
    min = [min, give_up_expected].min

    1.upto(a) do |c|
      back_correct   = b - a + 2 * c + 1
      back_incorrect = back_correct + b + 1

      p_back_correct = p[0..(a-c -1)].inject(&:*)

      back_expected = p_back_correct * back_correct + (1 - p_back_correct) * back_incorrect

      info "back(#{c}): #{back_expected}" if back_expected < min
      min = [min, back_expected].min
    end

    "%.6f" % min.to_f
  end

end
