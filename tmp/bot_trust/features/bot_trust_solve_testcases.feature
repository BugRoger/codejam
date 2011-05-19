Feature: Read test cases from file 
  
  As a code jam participant  
  I want provide test cases as a file 
  So that I solve the challenges 

    Scenario: solve all test cases in an input file 
      Given the input file is "data/test.in"  
      And the first line contains the number of test cases 
      When I start to solve it 
      Then I should see the result for each test case 
