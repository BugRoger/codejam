# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"

class SpeakingInTongues
  include CodeJam::Logging

  CIPHER = { 
    'y' => 'a', 'n' => 'b', 'f' => 'c', 'i' => 'd', 'c' => 'e', 'w' => 'f',
    'l' => 'g', 'b' => 'h', 'k' => 'i', 'u' => 'j', 'o' => 'k', 'm' => 'l',
    's' => 'n', 'x' => 'm', 'e' => 'o', 'v' => 'p', 'z' => 'q', 'p' => 'r',
    'd' => 's', 'r' => 't', 'j' => 'u', 'g' => 'v', 't' => 'w', 'h' => 'x',
    'a' => 'y', 'q' => 'z', ' ' => ' '
  }

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      puts "Case ##{i+1}: #{translate(input.shift.chomp)}"
    end
  end

  def translate(phrase)
    phrase.each_char.map do |c| 
      CIPHER.fetch(c) 
    end.join
  end
end
