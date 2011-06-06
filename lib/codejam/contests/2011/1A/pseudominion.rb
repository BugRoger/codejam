##
# Supporting code can be found at https://github.com/BugRoger/codejam
##
module CodeJam
  class PseuDominon < Problem 

    class Card < Struct.new(:cards, :score, :turns)
      def to_s 
        "(%s %s %s)" % [cards, score, turns]
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

      input.shift.to_i.times do
        @hand << Card.new(*input.shift.split.map(&:to_i))
      end

      input.shift.to_i.times do
        @deck << Card.new(*input.shift.split.map(&:to_i))
      end
    end

    def solve
      Game.new(@hand, @deck, 0, 1).score
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
      debugr "Starting Game"
      
      play card 
      score
    end

    def debugr(*args)
      debug *args if @debug
    end

    def score 
      debugr state 

      while @turns > 0 && @hand.size > 1
        case 
        when @hand.any? { |card| card.turns > 0 }
          debugr "Playing all turn cards:"
          play_turn_cards
        when @turns == 1
          debugr "Just one turn left. Playing card with highest score:"
          play best_score_card
        else
          debugr "Playing best card:"
          play best_card
        end
      end

      play @hand[0] if @hand.size == 1

      debugr "Finished Game"
      debugr state
      @score
    end

    def play_turn_cards
      @hand.each do |card| 
        play card unless card.turns == 0
      end
    end

    def best_card
      return best_score_card unless best_cards_card
      return best_cards_card unless best_score_card
      
      cards_score = Game.new(@hand.dup, @deck.dup, 0, 1, false).play_and_score(best_cards_card)
 
      return best_score_card if best_score_card.score > cards_score
      best_cards_card 
    end

    def best_score_card
      @hand.max_by { |c| c.score }
    end

    def best_cards_card
      @hand.max_by { |c| c.cards > 0 ? c.score : -1 }
    end



    def play(card)
      debugr "Playing: #{card}"

      @hand.delete(card)
      @turns -= 1
      
      @turns += card.turns
      @score += card.score
      card.cards.times do
        @hand << @deck.shift unless @deck.empty?
      end

      debugr state
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

