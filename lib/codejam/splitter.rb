module CodeJam
  module SingleLineSplitter 
    def parse(lines = [])
      count = lines.shift.to_i

      tests = []
      count.times do
        test = []
        test << lines.shift.chomp
        tests << test 
      end 

      tests
    end
  end

  module MultiLineSplitter
    def parse(lines = [])
      tests = []
      count = lines.shift.to_i

      count.times do
        length = lines[0].to_i
        tests << lines.slice!(0, length+1)
      end

      tests
    end
  end
end
