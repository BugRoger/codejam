require 'logger'

module CodeJam

  class SimpleFormatter < Logger::Formatter
    def call(severity, time, program_name, message)
      return "" unless ENV["DEBUG"]
      return "%s\n" % [message] 
    end
  end

  module Support
    def setup_logging
      @log           = Logger.new(STDERR)
      @log.level     = Logger::DEBUG
      @log.formatter = SimpleFormatter.new
    end

    def puts(*args)
      @output.puts(*args)    
    end
  end 

end
