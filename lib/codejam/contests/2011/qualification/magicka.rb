##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class Magicka < Problem 

    class Combo < Struct.new(:a, :b); end
    class Wipe  < Struct.new(:a, :b); end

    class Cast < String
      def apply!(combo)
        sub!(/#{combo.a}/, combo.b)
      end

      def triggers?(wipe)
        include?(wipe.a) && end_with?(wipe.b)
      end
    end


    def prepare(input)
      @combos = []
      @wipes  = []
      @cast   = Cast.new 
      
      tokens = input[0].split

      tokens.shift.to_i.times do
        a, b, c = tokens.shift.split(//)
        @combos << Combo.new(a+b, c) 
        @combos << Combo.new(b+a, c)
      end

      tokens.shift.to_i.times do
        a, b = tokens.shift.split(//)
        @wipes << Wipe.new(a, b)
        @wipes << Wipe.new(b, a)
      end

      _, @spell = tokens
    end 

    def solve
      @spell.each_char do |char|
        @cast << char
        combine!
        wipe! 
      end

      "[%s]" % @cast.split(//).join(", ")
    end 

    def combine!
      @combos.each { |combo| @cast.apply!(combo) }
    end

    def wipe!
      @cast.clear if @wipes.any? { |wipe| @cast.triggers?(wipe) }
    end
  end

end
