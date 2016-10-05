require './lib/errors'

module Draw
  # describes a line on the canvas
  class Line
    attr_reader :start, :finish, :content

    def initialize(start:, finish:, content:)
      @start, @finish, @content = start, finish, content
      fail InvalidLineError unless @start.linear_path_to?(@finish)
    end

    def each_point(_, &block)
      start.to(finish).each do |point|
        block.call(point)
      end
    end

    def blank?
      false
    end

    class InvalidLineError < DrawError; end
  end
end
