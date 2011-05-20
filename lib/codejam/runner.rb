module CodeJam

  class Runner
    include Support

    def initialize(problem, output)
      @problem = CodeJam.const_get(problem).new(output) 
      @output  = output
    end

    def solve(file_name)
      lines = File.open(file_name).readlines
      count = lines[0].to_i

      1.upto(count) do |i|
        input  = lines[i] 
        result = @problem.solve!(input) 
        puts "Case ##{i}: #{result}" 
      end 
    end
  end

end
