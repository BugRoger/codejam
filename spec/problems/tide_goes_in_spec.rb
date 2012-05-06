require 'problems/tide_goes_in'

describe TideGoesIn do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/tide_goes_in/test.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    TideGoesIn.new("data/tide_goes_in/test.in")
  end
end
