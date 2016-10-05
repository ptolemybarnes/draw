module Draw
  # prints a canvas
  class PrintCanvas
    def self.call(*args)
      new(*args).call
    end

    def initialize(canvas, styles)
      @canvas, @styles  = canvas, styles
    end

    def call
      canvas_top + canvas.map do |row|
        styles.style_for(:canvas_left_edge) +
          print_row(row) +
          styles.style_for(:canvas_right_edge)
      end.join + canvas_bottom
    end

    private
    attr_reader :canvas, :styles

    def canvas_top
      (styles.style_for(:canvas_top) * (width + 2)) + new_line
    end

    def canvas_bottom
      styles.style_for(:canvas_bottom) * (width + 2) + new_line
    end

    def canvas_middle
      styles.style_for(:canvas_left_edge) +
        (styles.style_for(:empty) * width) +
        styles.style_for(:canvas_right_edge)
    end

    def new_line
      styles.style_for(:new_line)
    end

    def width
      canvas.first.length
    end

    def print_row(row)
      row.map { |cell| cell.content }.join
    end
  end
end
