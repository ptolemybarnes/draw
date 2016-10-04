module Draw
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def points_around
      [ north, east, south, west ]
    end

    def == other
      x == other.x && y == other.y
    end

    def off?(grid)
      x < 0 || y < 0 || x >= grid.width || y >= grid.height
    end

    def find_on(content)
      content[y][x]
    end

    private

    def north
      Point.new(x, y + 1)
    end

    def east
      Point.new(x + 1, y)
    end

    def south
      Point.new(x, y + 1)
    end

    def west
      Point.new(x - 1, y)
    end
  end
end
