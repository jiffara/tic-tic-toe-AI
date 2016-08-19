require 'byebug'
require './skeleton/lib/00_tree_node.rb'
class KnightPathFinder

  MOVES = [
    [-1, -2],
    [-1, 2],
    [-2, -1],
    [-2, 1],
    [1, -2],
    [1, 2],
    [2, 1],
    [2, -1]
  ]

  def self.valid_moves(pos)
    possible_moves = MOVES.map do |x, y|
      [pos[0] + x, pos[1] + y]
    end.select do |u, v|
      [u, v].all? do |coord|
        coord.between?(0,7)
      end
    end
    possible_moves
  end

  def initialize(start = [0,0])
    @root_node = PolyTreeNode.new(start)
    @visited_positions = @root_node.value
    build_move_tree
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos).reject {|location| @visited_positions.include?(location)}
    @visited_positions += moves
    moves
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      current_node = queue.shift
      new_locations = new_move_positions(current_node.value)
      new_locations.each do |new_loc|
        new_node = PolyTreeNode.new(new_loc)
        current_node.add_child(new_node)
        queue << new_node
      end
      @root_node
    end
  end

  def find_path(end_pos)
    end_node = @root_node.dfs(end_pos)
    trace_path_back(end_node).reverse.map(&:value)
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node
    until current_node.nil?
      path << current_node
      current_node = current_node.parent
    end
    path
  end
end

if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([7,6])
end
