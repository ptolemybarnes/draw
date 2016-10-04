module Draw
  class Rectangle

    def initialize(top_left, bottom_right)
      @top_left, @bottom_right = top_left, bottom_right
    end

    def each_point _, &block
      [
        top_left,
        Point.new(bottom_right.x, top_left.y),
        bottom_right,
        Point.new(top_left.x, bottom_right.y),
        top_left
      ].each_cons(2) {|start, finish| Line.new(start: start, finish: finish).each_point(_, &block) }
    end

    def fill_content
      :line
    end

    private

    attr_reader :top_left, :bottom_right
  end
end
