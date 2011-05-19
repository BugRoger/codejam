module BotTrust
  class Robot
    def initialize(color)
      @color    = color
      @position = 1
      @safety   = true 
    end

    def program(test = [])
      @safety   = test[0][:color] != @color
      @program  = filter(test)
    end

    def filter(test = [])
      test.collect{ |set| set[:button] if set[:color] == @color }.compact
    end

    def next
      if @program.empty?
        return Hash[action: :stay, button: @position]
      end

      if @position == @program[0] 
        if permission_to_push?
          @program.shift
          return Hash[action: :push, button: @position]
        else
          return Hash[action: :stay, button: @position]
        end
      end
      
      if @program[0] > @position
        @position += 1 
      else
        @position -= 1
      end

      Hash[action: :move, button: @position]
    end

    def permission_to_push?
      @safety == false 
    end

    def safety(state) 
      @safety = state 
    end
  end
end
