require './lib/errors'

module Draw
  # describes a line on the canvas
  class Line

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

    def content
      @content.dup
    end

    private
    attr_reader :start, :finish

    class InvalidLineError < DrawError; end
  end
end
