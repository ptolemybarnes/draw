module Draw
  class SimpleStyle
    STYLES = {
      grid_top: '_',
      grid_bottom: '-',
      grid_left_edge: '|',
      grid_right_edge: "|\n",
      blank: ' ',
      line: :x,
      new_line: "\n"
    }

    def self.style_for(symbol)
      STYLES[symbol]
    end
  end
end
