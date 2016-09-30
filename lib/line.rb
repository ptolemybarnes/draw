require './lib/errors'

module Draw
  class Point < Struct.new(:x, :y); end

  class Line
    attr_reader :start, :finish

    def initialize(start:, finish:)
      @start, @finish = Point.new(*start), Point.new(*finish)
      raise InvalidLineError unless horizontal? || vertical?
    end

    def horizontal?
      start.y == finish.y
    end

    def vertical?
      start.x == finish.x
    end

    def each_point &block
      if horizontal?
        (start.x..finish.x).each do |x_coord|
          block.call(Point.new(x_coord, start.y))
        end
      else
        (start.y..finish.y).each do |y_coord|
          block.call(Point.new(start.x, y_coord))
        end
      end
    end

    class InvalidLineError < DrawError; end
  end
end

