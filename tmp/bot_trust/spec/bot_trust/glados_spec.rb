require 'spec_helper'

module BotTrust
  describe GLaDOS do

    let(:glados) { GLaDOS.new }
    let(:test)   { 
      [{color: :O, button: 2}, 
       {color: :B, button: 1},
       {color: :B, button: 2},
       {color: :O, button: 4}] 
    }
    
    describe "#solve" do
      
    end
  end
end
