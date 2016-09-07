module Draw
  class Canvas

    def initialize(width:, height:)
      @width, @height = width, height
      @styles = SimpleStyle
    end

    def render
      canvas_top + (canvas_middle * height) + canvas_bottom
    end

    private

    attr_reader :width, :height, :styles

    def canvas_top
      (styles.style_for(:canvas_top) * (width + 2)) + "\n"
    end

    def canvas_bottom
      styles.style_for(:canvas_bottom) * (width + 2) + "\n"
    end

    def canvas_middle
      styles.style_for(:canvas_left_edge) + (styles.style_for(:empty) * width) + styles.style_for(:canvas_right_edge)
    end
  end
end

class SimpleStyle

  STYLES = {
    canvas_top: '_',
    canvas_bottom: '-',
    canvas_left_edge: '|',
    canvas_right_edge: "|\n",
    empty: ' '
  }

  def self.style_for(symbol)
    STYLES[symbol]
  end

end
