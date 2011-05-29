module CodeJam
  class Runner 
    include Support

    def initialize(problem_class, file_name, output)
      @problem_class = CodeJam.const_get(problem_class) 
      @file_name     = file_name
      @output        = output
    end

    def solve
      input = File.open(@file_name).readlines

      results = []
      tests = @problem_class.parse(input)

      1.upto(tests.length) do |i|
        info "\n\n"
        info "-" * 100
        info "Case ##{i}:" 
        info "-" * 100
        info "\n#{tests[i-1].join}\n"

        result = @problem_class.new(tests[i-1], @output).solve
        print(i, result.to_s)
      end 
    end

    def print(i, result)
      lines = result.split("\n")
      
      if lines.length == 1
        puts "Case ##{i}: #{result}" 
      else 
        puts "Case ##{i}:"
        lines.each {|l| puts l}
      end
    end
  end
end
