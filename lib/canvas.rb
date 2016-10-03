require './lib/errors'
require './lib/point'
require './lib/grid'
require './lib/line'
require './lib/rectangle'
require './lib/fill'
require './lib/styles'
require './lib/print_grid'

module Draw
  class Canvas

    def initialize(width:, height:, grid: nil)
      @styles = SimpleStyle
      @grid   = grid || create_blank_grid(width, height)
    end

    def render
      grid.render
    end

    def draw_line(from:, to:)
      draw(Line.new(start: from, finish: to))
    end

    def draw_rectangle(from:, to:)
      draw(Rectangle.new(from, to))
    end

    def fill(x, y, fill_style)
      draw(Fill.new(x, y, fill_style))
    end

    def cell(x, y)
      grid.cell(x, y)
    end

    private

    attr_reader :styles
    attr_accessor :grid

    def draw(shape)
      current_grid = grid
      self.grid = grid.new_with(shape)
      self
    rescue OutOfBoundsError => e
      self.grid = current_grid
      raise e
    end

    def create_blank_grid(width, height)
      Grid.new(width, height)
    end
  end
end
