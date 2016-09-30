module Draw

  class Point < Struct.new(:x, :y); end

  class Line
    attr_reader :start, :finish

    def initialize(start:, finish:)
      @start, @finish = Point.new(*start), Point.new(*finish)
    end

    def horizontal?
      start.y == finish.y
    end
  end

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

    private

    attr_reader :styles, :width, :height, :content

    def place_line_in_content(line)
      new_content = content.dup
      if line.horizontal?
        (line.start.x..line.finish.x).each do |x_coord|
          new_content[line.start.y][x_coord] = :line
        end
      else
        (line.start.y..line.finish.y).each do |y_coord|
          new_content[y_coord][x_coord] = :line
        end
      end
      new_content
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

  class Canvas

    def initialize(width:, height:, grid: nil)
      @width, @height = width, height
      @styles = SimpleStyle
      @grid   = grid || create_blank_grid
    end

    def render
      grid.render
    end

    def draw_line(start:, finish:)
      @grid = grid.place(Line.new(start: start, finish: finish))
    end

    private

    attr_reader :width, :height, :styles, :grid

    def create_blank_grid
      Grid.new(width, height)
    end
  end
end

class SimpleStyle

  STYLES = {
    grid_top: '_',
    grid_bottom: '-',
    grid_left_edge: '|',
    grid_right_edge: "|\n",
    blank: ' ',
    line: :x
  }

  def self.style_for(symbol)
    STYLES[symbol]
  end

end
