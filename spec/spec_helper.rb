require 'codejam'
require 'stringio'

module CodeJam
  shared_examples_for "a correct solution" do |input|

    let(:output)   { double ('output').as_null_object }
    let(:problem)  { described_class.to_s.split("::").last }
    let(:runner)   { Runner.new(problem, File.join("data", input + ".in"), output) }

    it "should solve test.in and return content of test.out" do
      File.open(File.join("data", input + ".out")).each_line do |line|
        output.should_receive(:puts).with(line.chomp)
      end
     
      runner.solve
    end
  end
end
