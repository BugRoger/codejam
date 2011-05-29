require 'logger'

module CodeJam

  class SimpleFormatter < Logger::Formatter
    def call(severity, time, program_name, message)
      return "" unless ENV["DEBUG"]
      return "%s\n" % [message] 
    end
  end

  class << self
    attr_accessor :logger
  end

  @logger           = Logger.new(STDERR)
  @logger.level     = Logger::DEBUG
  @logger.formatter = SimpleFormatter.new
  
  module Support
    def logger
      CodeJam.logger
    end

    def debug(*args)
      CodeJam.logger.debug(*args)
    end

    def info(*args)
      CodeJam.logger.info(*args)
    end

    def puts(*args)
      @output.puts(*args)    
    end
  end 

end
