require './lib/cli'
require './lib/canvas'

module Draw
  describe CLI do

    subject(:cli) { CLI.new }
    let(:canvas)  do
      instance_double(Canvas, draw_line: nil, draw_rectangle: nil, render: nil, fill: nil)
    end

    before do
      allow(Canvas).to receive(:new).and_return(canvas)
    end

    specify 'creating a canvas' do
      cli.input('enter command: C 20 4')

      expect(Canvas).to have_received(:new).with(hash_including(width: 20, height: 4))
    end

    specify 'drawing a line on the canvas' do
      cli.input('enter command: C 20 4')
      cli.input('enter command: L 1 2 6 2')

      expect(canvas).to have_received(:draw_line)
        .with(from: [0, 1], to: [5, 1])
    end

    specify 'creating a fill' do
      cli.input('enter command: C 20 4')
      cli.input('enter command: B 10 3 o')

      expect(canvas).to have_received(:fill)
        .with(9, 2, 'o')
    end

    specify 'creating a rectangle' do
      cli.input('enter command: C 20 4')
      cli.input('enter command: R 16 1 20 3')

      expect(canvas).to have_received(:draw_rectangle)
        .with(from: [15, 0], to: [19, 2])
    end

    describe 'errors' do
      it 'commands must be correctly prefixed' do
        expect { cli.input('badly prefixed command') }.to raise_error(CLI::NoPrefixError)
      end

      it 'first token in a command must be a shape command' do
        expect { cli.input('enter command: 1 2 3 4') }.to raise_error(CLI::UnknownCommandError)
      end

      it 'first command must be to draw a canvas' do
        expect do
          cli.input('enter command: L 1 2 6 2')
        end.to raise_error(CLI::NoCanvasError)
      end
    end
  end
end
