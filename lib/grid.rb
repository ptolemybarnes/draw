module Draw
  class Grid

    def initialize(width, height, content = nil)
      @width, @height = width, height
      @content        = content || create_blank_grid(width, height)
      @styles         = SimpleStyle
    end

    def render
      grid_top + content.map do |row|
        styles.style_for(:grid_left_edge) +
          row.map {|cell| styles.style_for(cell) }.join +
          styles.style_for(:grid_right_edge)
      end.join + grid_bottom
    end

    def new_with(shape)
      Grid.new(width, height, new_content_with(shape))
    end

    def cell(x, y)
      content[y][x]
    end

    private

    attr_reader :styles, :width, :height, :content

    def new_content_with(shape)
      new_content = content.dup.map(&:dup)
      shape.each_point do |point|
        raise OutOfBoundsError.new(point) if off_grid?(point)
        new_content[point.y][point.x] = :line
      end
      new_content
    end

    def off_grid?(point)
      point.x >= width || point.y >= height
    end

    def grid_top
      (styles.style_for(:grid_top) * (width + 2)) + new_line
    end

    def grid_bottom
      styles.style_for(:grid_bottom) * (width + 2) + new_line
    end

    def grid_middle
      styles.style_for(:grid_left_edge) + (styles.style_for(:empty) * width) + styles.style_for(:grid_right_edge)
    end

    def new_line
      styles.style_for(:new_line)
    end

    def create_blank_grid(width, height)
      Array.new(height) { Array.new(width) { :blank }}
    end
  end
end
