module Draw
  # represents a 2D canvas
  class Canvas
    attr_reader :width, :height

    def initialize(width, height, grid = nil)
      @width, @height = width, height
      @grid         = grid || create_blank_grid(width, height)
    end

    def render_with(styles)
      PrintCanvas.call(grid.dup.map(&:dup), styles)
    end

    def new_with(shape)
      Canvas.new(width, height, new_grid_with(shape))
    end

    def points_around(center_point)
      center_point.neighbours.select do |point|
        on_canvas?(point) && empty_at?(point)
      end
    end

    private

    attr_reader :grid

    def empty_at?(point)
      grid[point.y][point.x].blank?
    end

    def on_canvas?(point)
      !off_canvas?(point)
    end

    def off_canvas?(point)
      point.x < 0 || point.y < 0 || point.x >= width || point.y >= height
    end

    def new_grid_with(shape)
      new_grid = grid.dup.map(&:dup)
      shape.each_point(self) do |point|
        fail(OutOfBoundsError, point) if off_canvas?(point)
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
