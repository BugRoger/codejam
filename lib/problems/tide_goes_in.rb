# Supporting code can be found at https://github.com/BugRoger/codejam
require "support/logging"
require "set"

class TideGoesIn 
  include CodeJam::Logging

  Square = Struct.new(:floor, :ceiling)

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      debug ">>>>>>>>>>>>>>>>>>>>>>>>   Case ##{i+1} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      
      initial_water_height, n, m = input.shift.chomp.split.map(&:to_i)
      grid = Hash.new { |h,k| h[k] = {} } 

      n.times do |i|
        x = input.shift.chomp.split.map(&:to_i)
        x.each_with_index do |v, j|
          grid[[i, j]][:ceiling] = v 
        end
      end

      n.times do |i|
        x = input.shift.chomp.split.map(&:to_i)
        x.each_with_index do |v, j|
          grid[[i, j]][:floor] = v
        end
      end

      debug "initial Water Height: #{initial_water_height}"
      debug grid.inspect

      puts "Case ##{i+1}: #{solve(initial_water_height, n, m, grid)}"
    end
  end

  def solve(initial_water_height, n, m, grid)
    AStar.new(initial_water_height, grid).total_cost([0,0], [n-1,m-1])
  end

  class AStar
    attr_accessor :g, :h, :f, :water_height

    def initialize(water_height, grid)
      @water_height = water_height
      @grid = grid
      @g = {}
      @h = {}
      @f = {}

      @water_sinking = false
    end

    def find(start, goal)
      closed    = Set.new  
      open      = Set.new [start]
      came_from = {}

      g[start] = 0
      h[start] = heuristic(start, goal) 
      f[start] = g[start] + h[start] 
      
      while !open.empty?
        current = open.min {|i| f[i]}
        return reconstruct(came_from, current) if current == goal

        open.delete(current)
        closed.add(current)

        neighbors(current).each do |neighbor|
          next if closed.include?(neighbor)
          tentative_g = g[current] + cost(current, neighbor)
        
          tentative_is_better = false 
          if !open.include?(neighbor)
            open.add(neighbor)
            h[neighbor] = heuristic(neighbor, goal)
            tentative_is_better = true
          elsif tentative_g < g[neighbor]
            tentative_is_better = true
          end

          if tentative_is_better
            came_from[neighbor] = current
            g[neighbor] = tentative_g
            f[neighbor] = g[neighbor] + h[neighbor]
          end
        end
      end

      raise "Fail"
    end

    def total_cost(start, goal)
      path = find(start, goal)

      prev = path.shift
      path.each do |s|
        cost = cost(prev, s)
        prev = s
      end

      g[goal]
    end

    def reconstruct(came_from, current)
      if came_from[current]
        p = reconstruct(came_from, came_from[current])
        return p << current
      else
        return [current]
      end
    end

    def neighbors(square)
      top    = [square[0], square[1]-1]
      bottom = [square[0], square[1]+1]
      left   = [square[0]-1, square[1]]
      right  = [square[0]+1, square[1]]

      neighbors = []
      neighbors << top unless blocked?(square, top) 
      neighbors << bottom unless blocked?(square, bottom) 
      neighbors << left unless blocked?(square, left) 
      neighbors << right unless blocked?(square, right) 

      neighbors
    end

    def blocked?(start, neighbor)
      return true if @grid[neighbor].empty?
      return true if (@grid[neighbor][:ceiling] - @grid[start][:floor]) < 50
      return true if (@grid[neighbor][:ceiling] - @grid[neighbor][:floor]) < 50
      return true if (@grid[start][:ceiling] - @grid[neighbor][:floor]) < 50
      false 
    end

    def heuristic(start, goal)
      goal[0] - start[0] + goal[1] - start[1]
    end

    def cost(current, neighbor)

      min_water_height = water_height - (@grid[neighbor][:ceiling] - 50) 
      wait = [min_water_height / 10.0, 0].max

      current_water_height = [water_height - (g[current] + wait) * 10, 0].max

      case
      when g[current] == 0 && wait == 0
        movement_cost = 0.0
      when current_water_height >= (@grid[current][:floor] + 20)
        movement_cost = 1.0
      else
        movement_cost = 10.0
      end

      wait + movement_cost
    end
  end

end
