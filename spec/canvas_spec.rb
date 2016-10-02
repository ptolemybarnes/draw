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

    describe 'drawing lines' do
      it 'prints a canvas with a horizontal line on it' do
        canvas = Canvas.new(width: 20, height: 4)
        canvas.draw_line(from: [0, 1], to: [5, 1])
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

      it 'prints a canvas with a vertical line on it' do
        canvas = Canvas.new(width: 20, height: 4)
        canvas.draw_line(from: [2, 0], to: [2, 2])
        expect(canvas.render).to eq(<<~EXAMPLE
          ______________________
          |  x                 |
          |  x                 |
          |  x                 |
          |                    |
          ----------------------
        EXAMPLE
        )
      end
    end

    describe 'drawing rectangles' do

      specify 'a rectangle can be drawn on the canvas' do
        canvas = Canvas.new(width: 20, height: 4)

        canvas.draw_rectangle(from: [15, 0], to: [19, 2])
        expect(canvas.render).to eq(<<~EXAMPLE
          ______________________
          |               xxxxx|
          |               x   x|
          |               xxxxx|
          |                    |
          ----------------------
        EXAMPLE
        )
      end
    end

    describe 'filling' do

      xit 'fills an area around a rectangle' do
        canvas = Canvas.new(width: 6, height: 4)

        canvas.draw_rectangle(from: [1, 1], to: [4, 2])
        canvas.fill(0, 0, :c)

        expect(canvas.render).to eq(<<~EXAMPLE
          ________
          |cccccc|
          |cxxxxc|
          |cxxxxc|
          |cccccc|
          --------
        EXAMPLE
        )
      end
    end

    describe 'bad drawings' do
      it "doesn't allow lines that run off the canvas" do
        canvas_width = 20
        canvas = Canvas.new(width: canvas_width, height: 4)

        expect do
          canvas.draw_line(from: [2, 0], to: [canvas_width + 1, 0])
        end.to raise_error(OutOfBoundsError)

        expect(canvas.cell(2, 0)).to eq :blank
      end
    end
  end
end
