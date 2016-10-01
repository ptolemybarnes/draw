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

    def place(line)
      Grid.new(width, height, place_line_in_content(line))
    end

    def cell(x, y)
      content[y][x]
    end

    private

    attr_reader :styles, :width, :height, :content

    def place_line_in_content(line)
      new_content = content.dup.map(&:dup)
      line.each_point do |point|
        raise OutOfBoundsError if off_grid?(point)
        new_content[point.y][point.x] = :line
      end
      new_content
    end

    def off_grid?(point)
      point.x >= width || point.y >= height
    end

    def grid_top
      (styles.style_for(:grid_top) * (width + 2)) + "\n"
    end

    def grid_bottom
      styles.style_for(:grid_bottom) * (width + 2) + "\n"
    end

    def grid_middle
      styles.style_for(:grid_left_edge) + (styles.style_for(:empty) * width) + styles.style_for(:grid_right_edge)
    end

    def create_blank_grid(width, height)
      Array.new(height) { Array.new(width) { :blank }}
    end
  end
end
