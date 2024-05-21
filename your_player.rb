class YourPlayer < BasePlayer
  def initialize(game:, name:)
    super
    @visited = {}
    @current_position = nil
  end

  def next_point(time:)
    @current_position ||= game.grid.starting_point

    dfs(game.grid, @current_position)
  end

  private

  def dfs(grid, current)
    return current if grid.all_visited?

    @visited[current] = true

    neighbors = grid.edges[current]

    neighbors.keys.each do |neighbor|
      next if @visited[neighbor]

      next_position = dfs(grid, neighbor)
      return next_position if next_position
    end

    @current_position = nil
    return nil
  end
end
