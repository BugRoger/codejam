module CodeJam
  class Problem 
    include Support

    def initialize(output)
      @output = output
    end

    def prepare(inout)
      raise 'this method should be overriden'
    end

    def solve(input = [])
      raise 'this method should be overriden'
    end

    def solve!(input)
      solve(prepare(input))
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
