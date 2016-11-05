require './lib/errors'
require './lib/point'
require './lib/canvas'
require './lib/line'
require './lib/rectangle'
require './lib/fill'
require './lib/styles'
require './lib/print_canvas'
require './lib/empty_shape'

module Draw
  # wraps and coordinates classes for showing and working on the project
  class Project
    def initialize(width:, height:)
      @canvas = create_blank_canvas(width, height)
    end

    def render
      canvas.render_with(SimpleStyle)
    end

    def draw_line(from:, to:)
      draw(Line.new(start: Point.new(*from), finish: Point.new(*to), content: 'x'))
    end

    def draw_rectangle(from:, to:)
      draw(Rectangle.new(from: Point.new(*from), to: Point.new(*to), content: 'x'))
    end

    def fill(x, y, fill_style)
      draw(Fill.new(Point.new(x, y), fill_style))
    end

    private

    attr_accessor :canvas

    def draw(shape)
      self.canvas = canvas.new_with(shape)
      self
    end

    def create_blank_canvas(width, height)
      Canvas.new(width, height)
    end
  end
end
