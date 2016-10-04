require './lib/errors'

module Draw
  # describes a line on the grid
  class Line
    attr_reader :start, :finish

    def initialize(start:, finish:)
      @start, @finish = start, finish
      fail InvalidLineError unless @start.linear_path_to?(@finish)
    end

    def each_point(_, &block)
      start.to(finish).each do |point|
        block.call(point)
      end
    end

    def fill_content
      :line
    end

    class InvalidLineError < DrawError; end
  end
end
