require 'problems/diamond_inheritance'

describe DiamondInheritance do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/diamond_inheritance/test.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    DiamondInheritance.new("data/diamond_inheritance/test.in")
  end
end
