##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class Magicka < Problem 

    class Combo < Struct.new(:a, :b, :c)
      def initialize(input)
        self.a = input[0]
        self.b = input[1]
        self.c = input[2]
      end
    end

    class Wipe  < Struct.new(:a, :b)
      def initialize(input)
        self.a = input[0]
        self.b = input[1]
      end
    end


    def prepare(input)
      tokens = input[0].split

      count  = tokens.shift.to_i
      @combos = []
      count.times do
        @combos.push Combo.new(tokens.shift)
      end 

      count = tokens.shift.to_i
      @wipes = []
      count.times do
        @wipes.push Wipe.new(tokens.shift)
      end 

      count = tokens.shift
      @spell = tokens.shift
    end 

    def solve
      list = "" 
      @spell.each_char do |char|
        list << char

        @combos.each do |combo|
          list.sub!(/#{combo.b}#{combo.a}/, "#{combo.c}")
          list.sub!(/#{combo.a}#{combo.b}/, "#{combo.c}")
        end
        
        @wipes.each do |wipe|
          list = "" if list[-1,1] == wipe.a and list.index(wipe.b)
          list = "" if list[-1,1] == wipe.b and list.index(wipe.a)
        end
      end

      "[%s]" % list.split(//).join(", ")
    end 
  end

end
