require 'problems/password_problem'

describe PasswordProblem do
  let(:output) { double ('output').as_null_object }
  
  it "should solve test.in and return content of test.out" do
    CodeJam.stub(:output).and_return(output)

    File.readlines("data/password_problem/A-small-practice.out").each do |line|
      output.should_receive(:puts).with(line.chomp)
    end

    PasswordProblem.new("data/password_problem/A-small-practice.in")
  end
end
