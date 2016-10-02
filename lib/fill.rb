module Draw
  class Fill
    attr_reader :fill_content

    def initialize(x, y, fill_content)
      @start_point  = Point.new(x, y)
      @fill_content = fill_content
    end

    def each_point &block
      block.call(@start_point)
    end
  end
end
