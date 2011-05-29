module CodeJam
  class Problem 
    include Support
    extend  SingleLineSplitter

    class << self
      attr_reader :classes

      def inherited(klass)
        @classes << klass.to_s.split("::").last
      end

    end
    
    @classes = []

    def initialize(test, output)
      @output   = output
      prepare(test)
    end

    def prepare(test)
      raise 'this method should be overriden'
    end

    def solve
      raise 'this method should be overriden'
    end
  end
end
