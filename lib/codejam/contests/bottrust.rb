##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class BotTrust < Problem

    class Instruction < Struct.new(:color, :position)
      def initialize(color, position)
        self.color    = color.eql?("B") ? :blue : :orange
        self.position = position.to_i
      end
    end

    def prepare(input)
      tokens = input[0].split
      count  = tokens.shift.to_i

      @sequence = []
      @orange   = []
      @blue     = []

      count.times do
        instruction = Instruction.new(tokens.shift, tokens.shift)
        
        @sequence << instruction
        @orange   << instruction if instruction.color == :orange 
        @blue     << instruction if instruction.color == :blue 
      end
    end

    def solve
      position = {blue: 1, orange: 1}
      time     = 0

      begin 
        next_color    = @sequence.first.color
        next_position = @sequence.first.position

        if next_position == position[:blue] && next_color == :blue 
          @blue.shift
          @sequence.shift
        else
          position[:blue] += 1 if @blue.first && @blue.first.position > position[:blue] 
          position[:blue] -= 1 if @blue.first && @blue.first.position < position[:blue]
        end

        if next_position == position[:orange] && next_color == :orange 
          @orange.shift
          @sequence.shift
        else
          position[:orange] += 1 if @orange.first && @orange.first.position > position[:orange] 
          position[:orange] -= 1 if @orange.first && @orange.first.position < position[:orange]
        end

        time += 1
      end until @sequence.empty? 

      time
    end
  end
end
