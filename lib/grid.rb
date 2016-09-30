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
          new_content[y_coord][line.start.x] = :line
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
end
