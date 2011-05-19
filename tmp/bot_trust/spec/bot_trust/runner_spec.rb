require 'spec_helper'

module BotTrust
  describe Runner do
    
    let(:output) { double('output').as_null_object }
    let(:runner) { Runner.new(output) }
    
    describe "#solve" do
      it "should return the result as integer" do
        runner.solve("2 B 2 B 1").should be_kind_of(Fixnum)  
      end
    end

    describe "#solve_file" do
      let(:data) { "3\n4 O 2 B 1 B 2 O 4\n3 O 5 O 8 B 100\n2 B 2 B 1" }
      
      it "should print a result for each test" do
        File.stub(:open).with("filename") { StringIO.new(data) }
        output.should_receive(:puts).with(/Case #\d: \d+/).exactly(3).times
        runner.solve_file("filename")
      end
    end

    describe "#parse" do
      it "should return an array with color/button sets" do
        result = runner.parse("4 B 1 O 2 B 3 B 4")
        result.should have(4).items  
      end

      it "should have color and button keys in each item" do
        result = runner.parse("4 B 1 O 2 B 3 B 4") 
        result.each do |set|
          set.should have_key(:color) 
          set.should have_key(:button)
          set[:button].should be_kind_of(Fixnum)
        end
      end

      it "should work" do
        result = runner.parse("4 O 2 B 1 B 2 O 4") 
        result.should be == [{color: :O, button: 2}, 
                             {color: :B, button: 1},
                             {color: :B, button: 2},
                             {color: :O, button: 4}]
      end
    end
  end
end
