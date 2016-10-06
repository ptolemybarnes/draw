require './lib/errors'

module Draw
  # provides access to a canvas point & computes points between 2 points
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def neighbours
      [north, east, south, west]
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def to(other)
      fail NonLinearPathError unless linear_path_to?(other)
      if y == other.y
        Range.new(*[x, other.x].sort).map {|new_x| Point.new(new_x, y) }
      else
        Range.new(*[y, other.y].sort).map {|new_y| Point.new(x, new_y) }
      end
    end

    def linear_path_to?(other)
      y == other.y || x == other.x
    end

    private

    def north; Point.new(x, y - 1); end
    def east;  Point.new(x + 1, y); end
    def south; Point.new(x, y + 1); end
    def west;  Point.new(x - 1, y); end
  end
end
