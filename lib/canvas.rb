require './lib/grid'
require './lib/line'

module Draw
  class Canvas

    def initialize(width:, height:, grid: nil)
      @width, @height = width, height
      @styles = SimpleStyle
      @grid   = grid || create_blank_grid
    end

    def render
      grid.render
    end

    def draw_line(start:, finish:)
      @grid = grid.place(Line.new(start: start, finish: finish))
    end

    private

    attr_reader :width, :height, :styles, :grid

    def create_blank_grid
      Grid.new(width, height)
    end
  end

  class SimpleStyle

    STYLES = {
      grid_top: '_',
      grid_bottom: '-',
      grid_left_edge: '|',
      grid_right_edge: "|\n",
      blank: ' ',
      line: :x
    }

    def self.style_for(symbol)
      STYLES[symbol]
    end

  end

  class DrawError < StandardError; end
end
