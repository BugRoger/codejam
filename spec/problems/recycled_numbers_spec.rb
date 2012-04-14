require 'codejam'

describe RecycledNumbers do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/recycled_numbers/test.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    RecycledNumbers.new("data/recycled_numbers/test.in")
  end
end
