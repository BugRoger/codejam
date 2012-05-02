require 'problems/kingdom_rush'

describe KingdomRush do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/kingdom_rush/B-small-practice.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    KingdomRush.new("data/kingdom_rush/B-small-practice.in")
  end
end
