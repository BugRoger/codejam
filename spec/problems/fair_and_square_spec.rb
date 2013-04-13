require 'problems/fair_and_square'

describe FairAndSquare do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/fair_and_square/test.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    FairAndSquare.new("data/fair_and_square/test.in")
  end
end
