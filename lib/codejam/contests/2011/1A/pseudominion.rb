##
# Supporting code can be found at https://github.com/BugRoger/codejam
##

require "set"
require "tsort"

  class Hash
    include TSort
    alias tsort_each_node each_key
    def tsort_each_child(node, &block)
      fetch(node, []).map{|v| v[:state]}.each(&block)
    end
  end

module CodeJam
  class PseuDominion < Problem 

    class Card < Struct.new(:draws, :score, :turns, :index)
      def to_s 
        "[%s %s %s](%s)" % [draws, score, turns, index]
      end

      def inspect
        to_s
      end
    end

    def self.parse(lines = [])
      tests = []
      count = lines.shift.to_i

      count.times do
        hand_size = lines[0].to_i
        deck_size = lines[hand_size + 1].to_i
        length = hand_size + deck_size + 2
        tests << lines.slice!(0, length).map(&:chomp)
      end

      tests
    end

    def prepare(input) 
      @hand = []
      @deck = []
      index = 0

      input.shift.to_i.times do
        @hand << Card.new(*input.shift.split.map(&:to_i), index)
        index += 1
      end

      input.shift.to_i.times do
        @deck << Card.new(*input.shift.split.map(&:to_i), index)
        index += 1
      end
    end

    def solve
      Game2.new(@hand, @deck).score
    #  Game.new(@hand, @deck, 0, 1).score
    end 

  end

  class State < Struct.new(:t, :d0, :d1, :d2, :hand_size, :turns)
    def to_s 
      "[%s %s %s %s %s %s]" % [t, d0, d1, d2, hand_size, turns]
    end

    def inspect
      to_s
    end
  end


  
  class Game2
    include Support

    def initialize(hand, deck)
      @hand  = hand
      @deck  = deck
      @cards = @hand + @deck

      @turn  = @cards.select{|c| c.turns > 0}.collect {|c| c.index }
      @draw0 = @cards.select{|c| c.draws == 0 && c.turns == 0}.collect {|c| c.index }
      @draw1 = @cards.select{|c| c.draws == 1 && c.turns == 0}.collect {|c| c.index }
      @draw2 = @cards.select{|c| c.draws == 2 && c.turns == 0}.collect {|c| c.index }

      debug "Turns: #{@turn}"
      debug "Draw0: #{@draw0}"
      debug "Draw1: #{@draw1}"
      debug "Draw2: #{@draw2}"

      root = State.new(0, 0, 0, 0, @hand.size, 1)
      debug root
      @nodes = Set.new 
      @nodes << root

      @edges = Hash.new { |h,k| h[k] = []  }

    end

    def score
      play(@nodes.first)
      debug "Nodes: #{@nodes.size} Edges: #{@edges.size}"
   #   debug @edges
   #   debug @edges.tsort
      return max_path
    end


    def max_path
      length = Hash.new(0)

      @edges.tsort.reverse.each do |vertex|
        @edges[vertex].each do |edge|
          length[edge[:state]] = length[vertex] + edge[:score] if length[edge[:state]] <= length[vertex] + edge[:score]
        end
      end

      return length.map{|v| v[1]}.max
    end

    def play(state)
      if state.turns == 0
        return
      end
      
      

      if @turn[state.t] && @turn[state.t] < state.hand_size
        card = @cards[@turn[state.t]]

        result = State.new(state.t + 1, state.d0, state.d1, state.d2, state.hand_size + card.draws, state.turns + card.turns - 1)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: card.score}
        return
      end
      

      if @draw0[state.d0] && @draw0[state.d0] < state.hand_size
        card = @cards[@draw0[state.d0]]

        result = State.new(state.t, state.d0+1, state.d1, state.d2, state.hand_size + card.draws, state.turns + card.turns - 1)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: card.score}



        
        result = State.new(state.t, state.d0+1, state.d1, state.d2, state.hand_size, state.turns)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: 0}

      end

      return if state.d0 > 0 
      


      if @draw1[state.d1] && @draw1[state.d1] < state.hand_size
        card = @cards[@draw1[state.d1]]

        result = State.new(state.t, state.d0, state.d1 + 1, state.d2, state.hand_size + card.draws, state.turns + card.turns - 1)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: card.score}




        result = State.new(state.t, state.d0, state.d1 + 1, state.d2, state.hand_size, state.turns)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: 0}


      end

      if @draw2[state.d2] && @draw2[state.d2] < state.hand_size
        card = @cards[@draw2[state.d2]]

        result = State.new(state.t, state.d0, state.d1, state.d2 + 1, state.hand_size + card.draws, state.turns + card.turns - 1)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: card.score}




        result = State.new(state.t, state.d0, state.d1 , state.d2 + 1, state.hand_size, state.turns)
        play result if @nodes.add? result
        @edges[state] << {state: result, score: 0}
      end

    end
  end


  class Game
    include Support

    def initialize(hand, deck, score, turns, debug = true)
      @hand  = hand
      @deck  = deck
      @score = score
      @turns = turns
      @debug = debug 
    end

    def play_and_score(card)
      debugr "Inception"
      
      play card 
      score
    end

    def debugr(*args)
      debug *args if @debug
    end

    def score 
      debugr "Starting Game"

      while @turns > 0 && @hand.size > 0
        debugr state 
        
        if @hand.size == 1
          debugr "Just one card on hand. Playing it:"
          play @hand[0]
        elsif @hand.any? { |c| c.turns > 0 }
          debugr "Playing all turn cards:"
          play_turn_cards
        else
          debugr "Playing best card:"
          play best_card
        end
      end

      debugr state 
      debugr "Finished Game"
      @score
    end

    def play_turn_cards
      @hand.select{ |c| c.turns > 0 }.each do |card| 
        play card unless card.turns == 0
      end
    end

    def best_card
      score = best_score_card
      cards = best_cards_card

      return score unless cards 
      return cards unless score 

      return cards if @hand.select{ |c| c.draws == 0 }.length < @turns 
      
      score_score = Game.new(@hand.dup, @deck.dup, 0, @turns, false).play_and_score(score)
      cards_score = Game.new(@hand.dup, @deck.dup, 0, @turns, false).play_and_score(cards)
 
     score_score > cards_score ? score : cards
    end

    def best_score_card
      @hand.select{ |c| c.draws == 0}.max_by { |c| c.score }
    end

    def best_cards_card
      @hand.select{ |c| c.draws > 0 }.max_by { |c| c.score }
    end



    def play(card)
      debugr "Playing: #{card}"

      @hand.delete_at @hand.find_index card
      @turns -= 1
      
      @turns += card.turns
      @score += card.score
      card.draws.times do
        @hand << @deck.shift unless @deck.empty?
      end

    end

    def state 
      <<-EOH

  Hand:  #{@hand}
  Deck:  #{@deck}
  Turns: #{@turns} Score: #{@score}
      EOH
    end

  end

end

