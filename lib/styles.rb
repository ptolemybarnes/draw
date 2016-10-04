module Draw
  # contains the characters for printing a grid
  class SimpleStyle
    STYLES = {
      grid_top: '_',
      grid_bottom: '-',
      grid_left_edge: '|',
      grid_right_edge: "|\n",
      line: :x,
      new_line: "\n",
      c: 'c',
      blank: ' '
    }

    def self.style_for(symbol)
      STYLES[symbol]
    end
  end
end
