require 'codejam'

describe SpeakingInTongues do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/speaking_in_tongues/test.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    SpeakingInTongues.new("data/speaking_in_tongues/test.in")
  end
end
