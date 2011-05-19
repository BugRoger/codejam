module BotTrust
  class GLaDOS

    def initialize(test, output)
      @test   = test
      @output = output

      @orange = Robot.new(:O)
      @blue   = Robot.new(:B)
    end

    def solve
      # @output.puts "Time | Orange               | Blue                "
      # @output.puts "-----+----------------------+---------------------"

      @blue.program(@test)
      @orange.program(@test)

      count = 0
      until done? do
        count += 1

        orange = @orange.next
        blue   = @blue.next
        
        # @output.puts "%4d | %20s | %20s | %20s " % [ count, orange, blue, @test[0] ] 

        announce_next_button if blue[:action] == :push || orange[:action] == :push
      end
      count
    end

    def announce_next_button
      @test.shift
      return if @test.empty?
      
      @orange.safety(@test[0][:color] != :O)
      @blue.safety(@test[0][:color] != :B)
    end

    def done? 
      @test.empty? 
    end

  end
end
