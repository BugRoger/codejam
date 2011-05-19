module Magicka
  class Runner
    def initialize(output)
      @output = output
    end

    def solve_file(file)
      lines = File.open(file).readlines
      count = lines[0].to_i

      i = 0 
      begin
        result = solve(lines[i + 1]) 
        @output.puts "Case ##{i+1}: [#{result.split(//).join(", ")}]"
        i += 1
      end while i < count
    end

    def solve(test)
      tokens = test.split

      count  = tokens.shift.to_i
      combos = []
      count.times do
        token = tokens.shift
        combos.push Hash[:a => token[0,1], :b => token[1,1], :c => token[2,1]]
      end 

      count  = tokens.shift.to_i
      oppos = []
      count.times do
        token = tokens.shift
        oppos.push Hash[:a => token[0,1], :b => token[1,1]]
      end 

      count = tokens.shift
      spell = tokens.shift

      list = ""
      spell.each_char do |char|
        list << char

        combos.each do |combo|
          list.sub!(/#{combo[:b]}#{combo[:a]}/, "#{combo[:c]}")
          list.sub!(/#{combo[:a]}#{combo[:b]}/, "#{combo[:c]}")
        end
        
        oppos.each do |oppo|
          list = "" if list[-1,1] == oppo[:a] and list.index(oppo[:b])
          list = "" if list[-1,1] == oppo[:b] and list.index(oppo[:a])
        end
      end

      list
    end
  end
end
