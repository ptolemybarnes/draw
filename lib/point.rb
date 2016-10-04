require './lib/errors'

module Draw
  # provides access to a grid point & computes points between 2 points
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

    def to(other, points = [])
      fail NonLinearPathError unless linear_path_to?(other)
      if points.last == other
        points
      else
        step_toward(other).to(other, points << self)
      end
    end

    def linear_path_to?(other)
      y == other.y || x == other.x
    end

    private

    def step_toward(other)
      return self if self == other
      if x == other.x
        Point.new(x, y.step_toward(other.y))
      else
        Point.new(x.step_toward(other.x), y)
      end
    end

    def north; Point.new(x, y + 1); end
    def east;  Point.new(x + 1, y); end
    def south; Point.new(x, y + 1); end
    def west;  Point.new(x - 1, y); end
  end
end
