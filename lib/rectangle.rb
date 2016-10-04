module Draw
  # describes the points in a rectangle of a given size on the canvas
  class Rectangle
    def initialize(top_left, bottom_right)
      @top_left, @bottom_right = top_left, bottom_right
    end

    def each_point(grid, &block)
      corners.each_cons(2) do |start, finish|
        Line.new(start: start, finish: finish).each_point(grid, &block)
      end
    end

    def corners
      [
        top_left,
        Point.new(bottom_right.x, top_left.y),
        bottom_right,
        Point.new(top_left.x, bottom_right.y),
        top_left
      ]
    end

    def fill_content
      :line
    end

    private

    attr_reader :top_left, :bottom_right
  end
end
