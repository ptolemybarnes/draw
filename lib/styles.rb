module Draw
  # contains the characters for printing a canvas
  class SimpleStyle
    STYLES = {
      canvas_top: '_',
      canvas_bottom: '-',
      canvas_left_edge: '|',
      canvas_right_edge: "|\n",
      new_line: "\n",
    }

    def self.style_for(symbol)
      STYLES[symbol]
    end
  end
end
