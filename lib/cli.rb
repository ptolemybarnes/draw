module Draw
  # translates user-input to commands that Project understands
  class CLI
    class CLIError < StandardError; end
    class NoPrefixError < CLIError; end
    class UnknownCommandError < CLIError; end
    class NoProjectError < CLIError; end

    module Commands
      PREFIX           = 'enter command:'
      DRAW_CANVAS      = 'C'
      DRAW_LINE        = 'L'
      DRAW_RECTANGLE   = 'R'
      DRAW_FILL        = 'B'
      EXIT             =  PREFIX + ' Q'
    end

    SHAPE_COMMANDS = {
      Commands::DRAW_CANVAS    => :project,
      Commands::DRAW_LINE      => :line,
      Commands::DRAW_RECTANGLE => :rectangle,
      Commands::DRAW_FILL      => :fill
    }

    def input(command)
      return if command.lstrip == Commands::EXIT
      execute(parse(command))
    end

    private

    attr_reader :project

    def parse(command)
      fail NoPrefixError unless command.slice!(Commands::PREFIX)
      tokens = command.lstrip.split.map { |arg| Token.new(arg) }
      fail UnknownCommandError unless tokens.first.shape_command?
      fail NoProjectError unless project ||
                                tokens.first.value == Commands::DRAW_CANVAS
      tokens
    end

    def execute(tokens)
      send('draw_' + SHAPE_COMMANDS[tokens.first.value].to_s, *tokens[1..-1])
      project.render
    end

    def draw_project(width, height)
      @project = Project.new(width: width.value, height: height.value)
    end

    def draw_line(*args)
      project.draw_line(
        from: args[0..1].map { |token| to_zero_index(token.value) },
        to:   args[2..3].map { |token| to_zero_index(token.value) }
      )
    end

    def draw_fill(x, y, fill_content)
      project.fill(
        to_zero_index(x.value.to_i), to_zero_index(y.value.to_i),
        fill_content.value
      )
    end

    def draw_rectangle(*args)
      project.draw_rectangle(
        from: args[0..1].map { |token| to_zero_index(token.value) },
        to:   args[2..3].map { |token| to_zero_index(token.value) }
      )
    end

    # as we use a zero-indexed array internally.
    def to_zero_index(integer)
      integer - 1
    end

    # represents a token of input from the user
    class Token
      def initialize(value)
        @value = value
      end

      def shape_command?
        !SHAPE_COMMANDS[value].nil?
      end

      def value
        return @value.to_i if integer?(@value)
        @value
      end

      private

      def integer?(value)
        value.to_i.to_s == value.to_s
      end
    end
  end
end
