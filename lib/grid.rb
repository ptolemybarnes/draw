module Draw
  # represents a 2D grid
  class Grid
    attr_reader :width, :height

    def initialize(width, height, content = nil)
      @width, @height = width, height
      @content        = content || create_blank_grid(width, height)
      @styles         = SimpleStyle
    end

    def render
      PrintGrid.call(content.dup.map(&:dup), styles)
    end

    def new_with(shape)
      Grid.new(width, height, new_content_with(shape))
    end

    def points_around(center_point)
      center_point.neighbours.reject do |point|
        off_grid?(point) || !empty_at?(point)
      end
    end

    private

    attr_reader :content, :styles

    def empty_at?(point)
      content[point.y][point.x] == :blank
    end

    def off_grid?(point)
      point.x < 0 || point.y < 0 || point.x >= width || point.y >= height
    end

    def new_content_with(shape)
      new_content = content.dup.map(&:dup)
      shape.each_point(self) do |point|
        fail(OutOfBoundsError, point) if off_grid?(point)
        new_content[point.y][point.x] = shape.fill_content
      end
      new_content.freeze.map(&:freeze)
    end

    def create_blank_grid(width, height)
      Array.new(height) { Array.new(width) { :blank } }
    end
  end
end
