module Draw
  # calculates which points on a canvas to fill from a given initial point
  class Fill
    def initialize(start, content)
      @start_point  = start
      @content = content
    end

    def each_point(canvas, initial_point = start_point, visited = [], &block)
      block.call(initial_point)
      visited << initial_point
      canvas.points_around(initial_point)
        .reject { |point| visited.include? point }
        .each   { |point| each_point(canvas, point, visited, &block) }
      canvas
    end

    def content
      @content.dup
    end

    private

    attr_reader :start_point
  end
end
