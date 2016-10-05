module Draw
  class CLI
    class CLIError < StandardError; end
    class NoPrefixError < CLIError; end
    class UnknownCommandError < CLIError; end
    class NoCanvasError < CLIError; end

    COMMAND_PREFIX = 'enter command:'
    attr_reader :canvas

    SHAPE_COMMANDS = {
      'C' => :canvas,
      'L' => :line,
      'R' => :rectangle,
      'B' => :fill
    }

    def input(command)
      execute(parse(command))
    end

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

    private
    attr_reader :canvas

    def parse(command)
      raise NoPrefixError unless command.slice!(COMMAND_PREFIX)
      tokens = command.lstrip.split.map {|arg| Token.new(arg) }
      raise UnknownCommandError unless tokens.first.shape_command?
      raise NoCanvasError unless canvas || tokens.first.value == 'C'
      tokens
    end

    def execute(tokens)
      send('create_' + SHAPE_COMMANDS[tokens.first.value].to_s, *tokens[1..-1])
    end

    def create_canvas(width, height)
      @canvas = Canvas.new(width: width.value, height: height.value)
    end

    def create_line(*args)
      canvas.draw_line(
        from: Point.new(*args[0..1].map {|token| token.value - 1 }),
        to:   Point.new(*args[2..3].map {|token| token.value - 1 })
      )
    end

    def create_fill(x, y, fill_content)
      canvas.fill(x.value.to_i - 1, y.value.to_i - 1, fill_content.value)
    end
  end
end
