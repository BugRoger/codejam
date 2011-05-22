require 'codejam'
require 'stringio'

module CodeJam
  shared_examples_for "a correct solution" do 
    let(:output)  { double ('output').as_null_object }
    let(:problem) { described_class.to_s.split("::").last }
    let(:runner)  { Runner.new(problem, "data/#{problem.downcase}/test.in", output) }

    it "should solve test.in and return content of test.out" do
      File.open("data/#{problem.downcase}/test.out").each_line do |line|
        output.should_receive(:puts).with(line.chomp)
      end
     
      runner.solve
    end
  end
end
