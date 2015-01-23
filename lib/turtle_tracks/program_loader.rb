module TurtleTracks
  class ProgramLoader
    def initialize(file_name)
      @parser = TurtleTracks::Parser.new
      @file_name = file_name
    end

    def get_program
      program = TurtleTracks::Program.new
      File.open(@file_name, 'r') do |f|
        f.each_line do |line|
          parse = @parser.parse(line)
          parse_to_command(parse, program)
        end
      end

      program
    end

    private

    def parse_to_command(parse, program)
      case
        when parse[:board_size]
          program.board_size = parse[:board_size][:int].to_i
        when parse[:rotate_clockwise]
          program.commands.push({ method: :rotate_clockwise, value: parse[:int].to_i })
        when parse[:rotate_counter_clockwise]
          program.commands.push({ method: :rotate_counter_clockwise, value: parse[:int].to_i })
        when parse[:move_forward]
          program.commands.push({ method: :move_forward, value: parse[:int].to_i })
        when parse[:move_backward]
          program.commands.push({ method: :move_backward, value: parse[:int].to_i })
        when parse[:repeat]
          parse[:int].to_i.times do
            parse[:actions].each do |action|
              parse_to_command(action, program)
            end
          end
      end
    end
  end

  class Program
    attr_accessor :board_size, :commands
    def initialize
      @board_size = 5
      @commands = []
    end
  end
end