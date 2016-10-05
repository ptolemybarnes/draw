require './lib/errors'
require './lib/point'
require './lib/grid'
require './lib/line'
require './lib/rectangle'
require './lib/fill'
require './lib/styles'
require './lib/print_grid'
require './lib/core_ext'

module Draw
  # wraps and coordinates classes for showing and working on the project
  class Project
    def initialize(width:, height:, grid: nil)
      @grid   = grid || create_blank_grid(width, height)
    end

    def render
      grid.render
    end

    def draw_line(from:, to:)
      draw(Line.new(start: Point.new(*from), finish: Point.new(*to), content: :x))
    end

    def draw_rectangle(from:, to:)
      draw(Rectangle.new(Point.new(*from), Point.new(*to), :x))
    end

    def fill(x, y, fill_style)
      draw(Fill.new(Point.new(x, y), fill_style))
    end

    protected

    attr_accessor :grid

    private

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
