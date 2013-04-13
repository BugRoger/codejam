# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"
require "set"

class DiamondInheritance 
  include CodeJam::Logging

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      klasses = []
      input.shift.to_i.times do |j|
        k, *a = input.shift.split.map(&:to_i)

        klasses << [j+1, a]
      end

      debug "Case ##{i+1}"
      debug klasses.inspect
      puts "Case ##{i+1}: #{solve(klasses)}"
    end
  end

  def solve(klasses)
    @ancestors = {}
    klasses.each do |k|
      @ancestors[k] = Set.new k[1]

      @ancestors[k].each do |ancestor|

      end



      return "Yes" if find_paths(k[0]).length > 1
    end

    return "No"
  end

  def inherits?(a, b)
    false
  end

  def find_paths(klass)
    @paths[klass] = [Set.new([klass])] unless @paths[klass]

    diamond_found = false
    @paths[klass].each do |path|
      @klasses[klass -1][1].each do |k|
        if path.include?(k)
          raise "Yes" if diamond_found 
          diamond_found = true
          next
        end

        find_paths(k).each do |inner|
          @paths[klass] << (path + inner)
        end

        @paths[klass].delete path
      end
    end


    @paths[klass]
  end
end
