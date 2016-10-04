module Draw
  class Grid
    attr_reader :width, :height

    def initialize(width, height, content = nil)
      @width, @height = width, height
      @content        = content || create_blank_grid(width, height)
      @styles         = SimpleStyle
    end

    def render
      PrintGrid.call(content.dup.map(&:dup), styles)
    end

    def new_with(shape)
      Grid.new(width, height, new_content_with(shape))
    end

    def points_around(point)
      point.points_around.reject {|point| point.off?(width, height) || !point.empty?(content) }
    end

    private
    attr_reader :content, :styles

    def new_content_with(shape)
      new_content = content.dup.map(&:dup)
      shape.each_point(self) do |point|
        raise OutOfBoundsError.new(point) if point.off?(width, height)
        point.fill(new_content, shape.fill_content)
      end
      new_content.freeze.map(&:freeze)
    end

    def create_blank_grid(width, height)
      Array.new(height) { Array.new(width) { :blank }}
    end
  end
end
