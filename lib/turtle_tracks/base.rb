require 'curses'

module TurtleTracks
  class Base
    def self.run_program_from_file(file)
      @loader = TurtleTracks::ProgramLoader.new(file)
      @program = @loader.get_program
      @model = TurtleTracks::Model.new(@program.board_size)
      @program.commands.each do |command|
        @model.send(command[:method], command[:value])
      end

      puts @model.to_s
      @model.to_s
    end

    def self.run_interactive
      run = true

      Curses.noecho
      Curses.init_screen
      Curses.stdscr.keypad(true)

      Signal.trap("SIGINT") do
        run = false
        Curses.close_screen
      end

      @model = TurtleTracks::Model.new(35)

      last_run = Time.now.to_f * 1000

      while run do
        current_run = Time.now.to_f * 1000
        t_delta = current_run - last_run
        fps = 1 / (t_delta / 1000)
        last_run = Time.now.to_f * 1000

        char = (STDIN.read_nonblock(1).ord rescue nil)

        case char
          when nil?
          when 65
            @model.move_forward
          when 66
            @model.move_backward
          when 67
            @model.rotate_clockwise(45)
          when 68
            @model.rotate_counter_clockwise(45)
        end
        char = nil

        Curses.setpos(0, 0)
        Curses.addstr("FPS: #{fps.round(1)}\n")
        Curses.addstr(@model.to_s)
        Curses.refresh
        sleep 1.0 / 60
      end
    end
  end
end