require './lib/canvas'
require 'pry'

module Draw
  describe Canvas do

    it 'prints an empty canvas' do
      canvas = Canvas.new(width: 20, height: 4)

      expect(canvas.render).to eq(<<~EXAMPLE
        ______________________
        |                    |
        |                    |
        |                    |
        |                    |
        ----------------------
      EXAMPLE
      )
    end

    it 'prints a canvas with a line on it' do
      canvas = Canvas.new(width: 20, height: 4)
      canvas.draw_line(start: [0, 1], finish: [5, 1])
      expect(canvas.render).to eq(<<~EXAMPLE
        ______________________
        |                    |
        |xxxxxx              |
        |                    |
        |                    |
        ----------------------
      EXAMPLE
      )
    end
  end
end
