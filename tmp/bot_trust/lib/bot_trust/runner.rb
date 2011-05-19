module BotTrust
  class Runner
    def initialize(output)
      @output = output
    end

    def solve_file(file)
      lines = File.open(file).readlines
      count = lines[0].to_i

      1.upto(count) do |i|
        input  = lines[i] 
        output = solve(input) 
        @output.puts "Case ##{i}: #{output}" 
      end 
    end

    def solve(test)
      glados = GLaDOS.new(parse(test), @output)
      glados.solve
    end

    def parse(test)
      tokens = test.split
      count  = tokens.shift

      result = []
      until tokens.empty?
        result.push({color: tokens.shift.to_sym, button: tokens.shift.to_i})
      end 

      result
    end
  end
end
