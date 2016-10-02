module Draw
  class Rectangle

    def initialize(top_left, bottom_right)
      @top_left, @bottom_right = Point.new(*top_left), Point.new(*bottom_right)
    end

    def each_point &block
      # top edge
      (top_left.x..bottom_right.x).each do |x_coord|
        block.call(Point.new(x_coord, top_left.y))
      end

      # left edge
      (top_left.y..bottom_right.y).each {|y_coord| block.call(Point.new(top_left.x, y_coord)) }

      # right edge
      (top_left.y..bottom_right.y).each {|y_coord| block.call(Point.new(bottom_right.x, y_coord)) }

      # bottom edge
      (top_left.x..bottom_right.x).each do |x_coord|
        block.call(Point.new(x_coord, bottom_right.y))
      end
    end

    def fill_content
      :line
    end

    private

    attr_reader :top_left, :bottom_right
  end
end
