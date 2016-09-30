require './lib/canvas'

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

    class InvalidLineError < DrawError; end
  end
end
