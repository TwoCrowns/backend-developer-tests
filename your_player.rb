require_relative 'base_player'

class YourPlayer < BasePlayer
  def initialize(game:, name:)
    super(game: game, name: name)
    @visited = {}
    @current_position = nil
  end

  def next_point(time:)
    return initial_position if initial_position

    neighbors = game.grid.edges[current_position]
    unvisited_neighbors = neighbors.keys.reject { |point| visited[point] }

    if unvisited_neighbors.empty?
      unvisited = game.grid.edges.keys - visited.keys
      return unvisited.sample unless unvisited.empty?
    else
      return unvisited_neighbors.min_by { |point| game.grid.move_cost(from: current_position, to: point) }
    end

    current_position
  end

  private

  def initial_position
    @current_position ||= { row: 0, col: 0 }
  end
end
