require './lib/project'
require 'pry'

module Draw
  describe Project do
    it 'prints an empty canvas' do
      project = Project.new(width: 20, height: 4)

      expect(project.render).to eq(<<~EXAMPLE
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
        project = Project.new(width: 20, height: 4)
        project.draw_line(from: [0, 1], to: [5, 1])
        expect(project.render).to eq(<<~EXAMPLE
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
        project = Project.new(width: 20, height: 4)
        project.draw_line(from: [2, 0], to: [2, 2])
        expect(project.render).to eq(<<~EXAMPLE
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
        project = Project.new(width: 20, height: 4)

        project.draw_rectangle(from: [15, 0], to: [19, 2])
        expect(project.render).to eq(<<~EXAMPLE
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
      it 'fills an area around a rectangle' do
        project = Project.new(width: 6, height: 4)

        project.draw_rectangle(from: [1, 1], to: [4, 2])
        project.fill(0, 0, 'c')

        expect(project.render).to eq(<<~EXAMPLE
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
        project_width = 20
        project = Project.new(width: project_width, height: 4)

        expect do
          project.draw_line(from: [2, 0], to: [project_width + 1, 0])
        end.to raise_error(OutOfBoundsError)
      end
    end
  end
end
