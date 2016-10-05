module Draw
  # represents a 2D grid
  class Grid
    attr_reader :width, :height

    def initialize(width, height, grid = nil)
      @width, @height = width, height
      @grid        = grid || create_blank_grid(width, height)
      @styles         = SimpleStyle
    end

    def render
      PrintGrid.call(grid.dup.map(&:dup), styles)
    end

    def new_with(shape)
      Grid.new(width, height, new_grid_with(shape))
    end

    def points_around(center_point)
      center_point.neighbours.reject do |point|
        off_grid?(point) || !empty_at?(point)
      end
    end

    private

    attr_reader :grid, :styles

    def empty_at?(point)
      grid[point.y][point.x].blank?
    end

    def off_grid?(point)
      point.x < 0 || point.y < 0 || point.x >= width || point.y >= height
    end

    def new_grid_with(shape)
      new_grid = grid.dup.map(&:dup)
      shape.each_point(self) do |point|
        fail(OutOfBoundsError, point) if off_grid?(point)
        new_grid[point.y][point.x] = shape
      end
      new_grid.freeze.map(&:freeze)
    end

    def create_blank_grid(width, height)
      Array.new(height) { Array.new(width) { EmptyShape.new(' ') } }
    end
  end

  class EmptyShape < Struct.new(:content)
    def blank?
      true
    end
  end

end
