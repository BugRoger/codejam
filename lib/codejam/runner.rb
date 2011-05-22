module CodeJam

  class Runner 
    include Support

    def initialize(problem_class, file_name, output)
      @problem_class = CodeJam.const_get(problem_class) 
      @file_name     = file_name
      @output        = output

      setup_logging
    end

    def solve
      input = File.open(@file_name).readlines

      results = []
      tests = @problem_class.split(input) 



      1.upto(tests.length) do |i|
        @log.info "-" * 100
        @log.info "Case ##{i}:" 
        @log.info "-" * 100
        @log.info ""
        @log.info tests[i-1].join
        @log.info "" 

        result = @problem_class.new(tests[i-1], @output).solve
        print(i, result.to_s)
      end 
    end

    def print(i, result)
      lines = result.split("\n")
      
      @log.info ""
      if lines.length == 1
        puts      "Case ##{i}: #{result}" 
        @log.info "Case ##{i}: #{result}\n"
      else 
        puts      "Case ##{i}:"
        @log.info "Case ##{i}:"
        
        lines.each {|l| puts l; @log.info l}
      end
      @log.info ""
      @log.info ""
      
    end
  end

end
