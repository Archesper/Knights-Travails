require 'pry-byebug'

class Graph
  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def add_node(node)
    @nodes << node
  end

  def bfs(target, node = @nodes[0])
    frontier = QueueFrontier.new
    frontier.queue.unshift({ predecessor: nil, node: node })
    until frontier.queue.empty?
      current_node = frontier.queue.pop
      if current_node[:node] == target
        path = []
        until current_node.nil?
          path << current_node[:node]
          current_node = current_node[:predecessor]
        end
        return path.reverse
      end

      frontier.discovered_nodes << current_node
      current_node[:node].neighbors.each do |neighbor|
        neighbor = BoardNode.new(*neighbor)
        unless frontier.discovered_nodes.any? { |hash| hash[:node] == neighbor }
          frontier.queue.unshift({ predecessor: current_node, node: neighbor })
        end
      end
    end
  end
end

class QueueFrontier
  attr_reader :queue, :discovered_nodes

  def initialize
    @discovered_nodes = []
    @queue = []
  end

  def discovered?(node)
    @discovered_nodes.include? node
  end
end
