require './lib/cli'
require './lib/canvas'

module Draw
  describe CLI do

    subject(:cli) { CLI.new }

    specify 'creating a canvas' do
      allow(Canvas).to receive(:new)

      cli.input('enter command: C 20 4')

      expect(Canvas).to have_received(:new).with(hash_including(width: 20, height: 4))
    end

    specify 'drawing a line on the canvas' do
      mock_canvas = instance_double(Canvas, draw_line: nil)
      allow(Canvas).to receive(:new).and_return(mock_canvas)

      cli.input('enter command: C 20 4')
      cli.input('enter command: L 1 2 6 2')

      expect(mock_canvas).to have_received(:draw_line)
        .with(from: Point.new(0, 1), to: Point.new(5, 1))
    end

    specify 'creating a fill' do
      mock_canvas = instance_double(Canvas, fill: nil)
      allow(Canvas).to receive(:new).and_return(mock_canvas)

      cli.input('enter command: C 20 4')
      cli.input('enter command: B 10 3 o')

      expect(mock_canvas).to have_received(:fill)
        .with(9, 2, 'o')
    end

    describe 'errors' do
      it 'commands must be correctly prefixed' do
        expect { cli.input('badly prefixed command') }.to raise_error(CLI::NoPrefixError)
      end

      it 'first token in a command must be a shape command' do
        expect { cli.input('enter command: 1 2 3 4') }.to raise_error(CLI::UnknownCommandError)
      end

      it 'first command must be to create a canvas' do
        expect do
          cli.input('enter command: L 1 2 6 2')
        end.to raise_error(CLI::NoCanvasError)
      end
    end
  end
end
