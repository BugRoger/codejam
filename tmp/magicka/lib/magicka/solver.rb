module Magicka
  class Solverr

    def initalize(combos, oppos, spell)
      @combos = combos
      @oppos  = oppos
      @spell  = spell
    end


    def solve
      list = ""
      @spell.each_char do |char|
        list << char

        @combos.each do |combo|
          list.sub!(/#{@combo[:b]}#{@combo[:a]}/, "#{@combo[:c]}")
          list.sub!(/#{@combo[:a]}#{@combo[:b]}/, "#{@combo[:c]}")
        end
        
        @oppos.each do |oppo|
          list = "" if list[-1,1] == @oppo[:a] and list.index(@oppo[:b])
          list = "" if list[-1,1] == @oppo[:b] and list.index(@oppo[:a])
        end
      end

      list
    end
  end
end
