class BoardNode
  attr_reader :x, :y, :neighbors

  def initialize(x, y)
    @x = x
    @y = y
    @neighbors = []
  end

  def add_edge(*nodes)
    @neighbors.push(*nodes)
  end
end

class Graph
  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def add_node(node)
    @nodes << node
  end
end

class KnightsGraph < Graph
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
      node = BoardNode.new(cell[0], cell[1])
      node.add_edge(*Knight.valid_moves(node))
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
      [x - 2, y - 1],
    ]
    valid_moves = potential_moves.select do |move|
      (0..7).include?(move[0]) && (0..7).include?(move[1])
    end
  end
end