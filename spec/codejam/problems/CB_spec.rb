require 'spec_helper'

module CodeJam 
  describe CB do
    it_should_behave_like "a correct solution" 

    let(:output)  { double ('output').as_null_object }
    let(:problem) { described_class.to_s.split("::").last }
    let(:runner)  { Runner.new(problem, "data/#{problem.downcase}/B-small-practice.in", output) }

    it "should solve small input set correctly" do
      File.open("data/#{problem.downcase}/B-small-practice.out").each_line do |line|
        output.should_receive(:puts).with(line.chomp)
      end
     
      runner.solve
    end

  end
end
