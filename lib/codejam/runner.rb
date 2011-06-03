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
        info "\n#{tests[i-1].join("\n")}\n"

        result = @problem_class.new(tests[i-1], @output).solve
        print(i, result)
      end 
    end

    def print(i, result)
      if result.respond_to?(:each) 
        puts "Case ##{i}:"
        result.each {|l| puts l}
      else 
        puts "Case ##{i}: #{result}" 
      end
    end
  end
end
