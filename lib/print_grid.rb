module Draw
  class PrintGrid
    def self.call(*args)
      new(*args).call
    end

    def initialize(content, styles)
      @content, @styles  = content, styles
    end

    def call
      grid_top + content.map do |row|
        styles.style_for(:grid_left_edge) +
          row.map {|cell| styles.style_for(cell) }.join +
          styles.style_for(:grid_right_edge)
      end.join + grid_bottom
    end

    def grid_top
      (styles.style_for(:grid_top) * (width + 2)) + new_line
    end

    def grid_bottom
      styles.style_for(:grid_bottom) * (width + 2) + new_line
    end

    def grid_middle
      styles.style_for(:grid_left_edge) + (styles.style_for(:empty) * width) + styles.style_for(:grid_right_edge)
    end

    def new_line
      styles.style_for(:new_line)
    end

    private

    def width
      content.first.length
    end

    attr_reader :content, :styles
  end
end
