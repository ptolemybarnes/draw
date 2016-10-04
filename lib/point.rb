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

    def off?(width, height)
      x < 0 || y < 0 || x >= width || y >= height
    end

    def find_on(content)
      content[y][x]
    end

    def empty?(content)
      find_on(content) == :blank
    end

    def fill(content, fill_content)
      content[y][x] = fill_content
    end

    def linear_path_to?(other)
      y == other.y || x == other.x
    end

    def to(other, range = [])
      raise unless linear_path_to?(other)
      if range.last == other
        range
      else
        step_toward(other).to(other, range << self)
      end
    end

    private

    def step_toward(other)
      if self == other
        self
      elsif x == other.x
        Point.new(x, y.step_toward(other.y))
      else
        Point.new(x.step_toward(other.x), y)
      end
    end

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
