require './lib/errors'
require './lib/grid'
require './lib/line'
require './lib/rectangle'

def render canvas
  puts canvas.render
end

module Draw
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
      current_grid = grid
      self.grid = grid.place(Line.new(start: start, finish: finish))
    rescue OutOfBoundsError => e
      self.grid = current_grid
      raise e
    end

    def draw_rectangle(from:, to:)
      current_grid = grid
      self.grid = grid.place(Rectangle.new(from, to))
    rescue OutOfBoundsError => e
      self.grid = current_grid
      raise e
    end

    def cell(x, y)
      grid.cell(x, y)
    end

    private

    attr_reader :width, :height, :styles
    attr_accessor :grid

    def create_blank_grid
      Grid.new(width, height)
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
end
