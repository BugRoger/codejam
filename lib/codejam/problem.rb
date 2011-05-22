module CodeJam
  class Problem 
    include Support

    def initialize(test, output)
      @output = output

      setup_logging
      prepare(test)
    end

    def self.split(input)
      count = input[0].to_i

      tests = []
      1.upto(count) do |i|
        tests << input[i]
      end 

      tests
    end

    def prepare(test)
      raise 'this method should be overriden'
    end

    def solve
      raise 'this method should be overriden'
    end

    def self.subclasses
      classes = []
      ObjectSpace.each_object do |klass|
        next unless Module === klass
        classes << klass.to_s.split("::").last if self > klass
      end
      classes
    end
  end
end
