##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class NoMoreBluePixels < Exception; end
  class ImpossiblePainting < Exception; end

  class SquareTiles < Problem 
    extend MultiLineSplitter

    def prepare(input)
      @height, @width = input.shift.split.map(&:to_i)
      debug "Size: #{@width}x#{@height}"

      @painting = input
    end 

    def solve
      while true 
        x, y = topleft_blue_pixel 
        paint x, y 
      end

    rescue NoMoreBluePixels
      @painting
    rescue ImpossiblePainting
      debug @painting.join("\n")
      ["Impossible"]
    end 

    def paint(x, y)
      paint_pixel(x, y, "/")
      paint_pixel(x + 1, y, "\\")
      paint_pixel(x, y + 1, "\\")
      paint_pixel(x + 1, y + 1, "/")
    end

    def paint_pixel(x, y, color)
      raise ImpossiblePainting if x >= @width || y >= @height 
      raise ImpossiblePainting unless @painting[y][x] == "#"

      @painting[y][x] = color
    end

    def topleft_blue_pixel
      0.upto(@height - 1) do |y|
        0.upto(@width - 1) do |x|
          return x, y if @painting[y][x] == "#"
        end
      end

      raise NoMoreBluePixels
    end
  end

end
