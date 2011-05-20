require 'codejam'
require 'stringio'

module CodeJam
  shared_examples_for "a problem that" do |name|
    let(:output)  { double ('output').as_null_object }
    let(:runner)  { Runner.new(name, output) }

    it "solved test.in and return content of test.out" do

      File.open("data/#{name.downcase}/test.out").each_line do |line|
        output.should_receive(:puts).with(line.chomp)
      end
     
      runner.solve("data/#{name.downcase}/test.in")
    end
  end
end
