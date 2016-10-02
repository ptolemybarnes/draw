require './lib/errors'
require './lib/grid'
require './lib/line'
require './lib/rectangle'
require './lib/styles'

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
      draw(Line.new(start: start, finish: finish))
    end

    def draw_rectangle(from:, to:)
      draw(Rectangle.new(from, to))
    end

    def cell(x, y)
      grid.cell(x, y)
    end

    private

    attr_reader :width, :height, :styles
    attr_accessor :grid

    def draw(shape)
      current_grid = grid
      self.grid = grid.new_with(shape)
    rescue OutOfBoundsError => e
      self.grid = current_grid
      raise e
    end

    def create_blank_grid
      Grid.new(width, height)
    end
  end
end
