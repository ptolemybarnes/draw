require './lib/cli'
require './lib/project'

module Draw
  describe CLI do
    subject(:cli) { CLI.new }
    let(:project)  do
      instance_double(Project, draw_line: nil, draw_rectangle: nil, render: nil, fill: nil)
    end

    before do
      allow(Project).to receive(:new).and_return(project)
    end

    specify 'creating a project' do
      cli.input('C 20 4')

      expect(Project).to have_received(:new).with(hash_including(width: 20, height: 4))
    end

    specify 'drawing a line on the project' do
      cli.input('C 20 4')
      cli.input('L 1 2 6 2')

      expect(project).to have_received(:draw_line)
        .with(from: [0, 1], to: [5, 1])
    end

    specify 'creating a fill' do
      cli.input('C 20 4')
      cli.input('B 10 3 o')

      expect(project).to have_received(:fill)
        .with(9, 2, 'o')
    end

    specify 'creating a rectangle' do
      cli.input('C 20 4')
      cli.input('R 16 1 20 3')

      expect(project).to have_received(:draw_rectangle)
        .with(from: [15, 0], to: [19, 2])
    end

    describe 'errors' do
      it 'first token in a command must be a shape command' do
        expect { cli.input('1 2 3 4') }.to raise_error(CLI::UnknownCommandError)
      end

      it 'first command must be to draw a project' do
        expect do
          cli.input('L 1 2 6 2')
        end.to raise_error(CLI::NoProjectError)
      end
    end
  end
end
