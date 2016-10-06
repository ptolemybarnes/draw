require './lib/errors'
require './lib/point'
require './lib/canvas'
require './lib/line'
require './lib/rectangle'
require './lib/fill'
require './lib/styles'
require './lib/print_canvas'

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

    protected

    attr_accessor :canvas

    private

    def draw(shape)
      current_canvas = canvas
      self.canvas = canvas.new_with(shape)
      self
    rescue OutOfBoundsError => e
      self.canvas = current_canvas
      raise e
    end

    def create_blank_canvas(width, height)
      Canvas.new(width, height)
    end
  end
end
