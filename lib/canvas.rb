module Draw
  # represents a 2D canvas
  class Canvas
    attr_reader :width, :height

    def initialize(width, height, canvas = nil)
      @width, @height = width, height
      @canvas         = canvas || create_blank_canvas(width, height)
    end

    def render_with(styles)
      PrintCanvas.call(canvas.dup.map(&:dup), styles)
    end

    def new_with(shape)
      Canvas.new(width, height, new_canvas_with(shape))
    end

    def points_around(center_point)
      center_point.neighbours.reject do |point|
        off_canvas?(point) || !empty_at?(point)
      end
    end

    private

    attr_reader :canvas

    def empty_at?(point)
      canvas[point.y][point.x].blank?
    end

    def off_canvas?(point)
      point.x < 0 || point.y < 0 || point.x >= width || point.y >= height
    end

    def new_canvas_with(shape)
      new_canvas = canvas.dup.map(&:dup)
      shape.each_point(self) do |point|
        fail(OutOfBoundsError, point) if off_canvas?(point)
        new_canvas[point.y][point.x] = shape
      end
      new_canvas.freeze.map(&:freeze)
    end

    def create_blank_canvas(width, height)
      Array.new(height) { Array.new(width) { EmptyShape.new(' ') } }
    end
  end

  class EmptyShape < Struct.new(:content)
    def blank?
      true
    end
  end

end
