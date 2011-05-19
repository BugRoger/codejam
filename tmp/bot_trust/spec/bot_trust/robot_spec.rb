require 'spec_helper'

module BotTrust
  describe Robot do 

    let(:robot) { Robot.new(:O) }
    let(:test)   { 
      [{color: :O, button: 2}, 
       {color: :B, button: 1},
       {color: :B, button: 2},
       {color: :O, button: 4}] 
    }

    describe "#filter" do
      it "should filter the program by color" do
        robot.filter(test).should be == [2,4] 
      end
    end
  end
end
