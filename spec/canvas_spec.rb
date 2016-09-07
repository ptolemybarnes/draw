require './lib/canvas'

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
    end
  end
end
