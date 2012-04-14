# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"
require 'set'

class RecycledNumbers 
  include CodeJam::Logging

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      a, b = input.shift.chomp.split.map(&:to_i)
      puts "Case ##{i+1}: #{count_pairs(a, b)}"
    end
  end

  def pairs
    begin
      @pairs ||= File.open("precalc.bin") { |file| Marshal.load(file) }
    rescue
      @pairs = recycled_pairs(1,2000000)
      File.open("precalc.bin", "w") { |file| Marshal.dump(@pairs, file) }
    end

    @pairs
  end

  def recycled_pairs(a, b)
    pairs = Set.new 

    a.upto(b - 1) do |n|
      start = n.to_s.split(//)

      1.upto(start.size) do |digits|
        m = start.rotate(digits).join.to_i

        next unless n < m
        next unless m <= b
        next if pairs.include? [n, m]

        pairs.add([n, m])
      end
    end

    pairs
  end

  def count_pairs(a, b) 
    count = 0
    pairs.each do |p|
      count += 1 if (p[0] >= a && p[1] <= b)
    end
    count
  end
end
