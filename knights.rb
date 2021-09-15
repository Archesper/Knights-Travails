# frozen_string_literal: true

require_relative 'graph'

class KnightMoveNode
  attr_reader :x, :y, :neighbors

  def initialize(*coordinates)
    @x = coordinates[0]
    @y = coordinates[1]
    @neighbors = Knight.valid_moves(self)
  end

  def coordinates
    [@x, @y]
  end

  def ==(other)
    x == other.x && y == other.y
  end
end

class BoardGraph < Graph
  attr_reader :nodes

  def initialize
    super
    board_cells = []
    8.times do |x|
      8.times do |y|
        board_cells << [x, y]
      end
    end
    board_cells.each do |cell|
      node = KnightMoveNode.new(cell[0], cell[1])
      add_node(node)
    end
  end
end

class Knight
  def self.valid_moves(cell)
    x = cell.x
    y = cell.y
    potential_moves = [
      [x + 1, y + 2],
      [x - 1, y + 2],
      [x + 2, y + 1],
      [x - 2, y + 1],
      [x + 1, y - 2],
      [x - 1, y - 2],
      [x + 2, y - 1],
      [x - 2, y - 1]
    ]
    potential_moves.select do |move|
      (0..7).include?(move[0]) && (0..7).include?(move[1])
    end
  end

  def knight_moves(start, finish)
    start = KnightMoveNode.new(*start)
    finish = KnightMoveNode.new(*finish)
    board = BoardGraph.new
    moves = board.bfs(finish, start).map { |node| node.coordinates }
    puts "You made it in #{moves.length - 1} moves! Here's your path:"
    moves.each { |move| p move }
  end
end
