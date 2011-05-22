module CodeJam
  class Splitter
    def parse(lines = [])
      raise "Implement me"
    end
  end

  class SingleLineSplitter < Splitter
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

  class MultiLineSplitter < Splitter
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
