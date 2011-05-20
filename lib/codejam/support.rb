module CodeJam

  module Support
    def puts(*args)
      @output.puts(*args)    
    end

    def debug(*args)
      @output.puts(*args) if ENV["DEBUG"]
    end
  end

end
