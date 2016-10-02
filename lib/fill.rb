module Draw
  class Fill
    attr_reader :fill_content, :start_point

    def initialize(x, y, fill_content)
      @start_point  = Point.new(x, y)
      @fill_content = fill_content
    end

    def each_point grid, initial_point = start_point, visited_points = [], &block
      block.call(initial_point)
      visited_points << initial_point
      grid.points_around(initial_point)
        .reject {|point| visited_points.include? point }
        .each   {|point| each_point(grid, point, visited_points, &block) }
    end
  end
end
