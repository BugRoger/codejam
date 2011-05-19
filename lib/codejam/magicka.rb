#!/usr/bin/env ruby

module CodeJam
  class Runner
    def initialize(output)
      @solver = Magicka.new(output) 
      @output = output
    end

    def solve(file)
      lines = File.open(file).readlines
      count = lines[0].to_i

      1.upto(count) do |i|
        input  = lines[i] 
        result = @solver.solve(input) 
        puts "Case ##{i}: #{result}" 
      end 
    end

    def puts(*args)
      @output.puts(*args)    
    end
  end


  class Solver
    def initialize(output)
      @output = output
    end

    def solve(input)
      raise 'this method should be overriden'
    end

    def puts(*args)
      @output.puts(*args)    
    end
  end


  class Magicka < Solver
    def parse(input)
      tokens = input.split

      count  = tokens.shift.to_i
      combos = []
      count.times do
        combos.push Combo.new(tokens.shift)
      end 

      count = tokens.shift.to_i
      wipes = []
      count.times do
        wipes.push Wipe.new(tokens.shift)
      end 

      count = tokens.shift
      spell = tokens.shift

      return combos, wipes, spell
    end 

    def solve(input)
      combos, wipes, spell = parse(input)

      list = "" 
      spell.each_char do |char|
        list << char

        combos.each do |combo|
          list.sub!(/#{combo.b}#{combo.a}/, "#{combo.c}")
          list.sub!(/#{combo.a}#{combo.b}/, "#{combo.c}")
        end
        
        wipes.each do |wipe|
          list = "" if list[-1,1] == wipe.a and list.index(wipe.b)
          list = "" if list[-1,1] == wipe.b and list.index(wipe.a)
        end
      end

      "[%s]" % list.split(//).join(", ")
    end 
  end

  class Combo < Struct.new(:a, :b, :c)
    def initialize(input)
      self.a = input[0]
      self.b = input[1]
      self.c = input[2]
    end
  end

  class Wipe  < Struct.new(:a, :b)
    def initialize(input)
      self.a = input[0]
      self.b = input[1]
    end
  end
end

abort("Give me a file") unless ARGV[0]
CodeJam::Runner.new(STDOUT).solve(ARGV[0])
