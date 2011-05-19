Given /^the input file is "([^"]*)"$/ do |file|
  @file = file
end


When /^I start to solve it$/ do
  @runner = BotTrust::Runner.new(output)
  @runner.solve_file(@file)
end

Given /^the input file contains "([^"]*)" test cases$/ do |count|
  @test_case_count = count.to_i
end

Then /^I should see the result for each test case$/ do
  output.messages.should have(@test_case_count).results
end

Given /^the first line contains the number of test cases$/ do
  @test_case_count = File.open(@file, &:readline).to_i
end


class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

