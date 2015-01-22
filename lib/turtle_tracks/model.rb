module TurtleTracks
  class Model
    attr_reader :pos, :heading

    def initialize(board_size)
      @board_size = board_size
      reset(@board_size)
    end

    def reset(board_size = @board_size)
      @board = Array.new(board_size) { Array.new(board_size, '.') }
      @pos = [(board_size / 2).floor, (board_size / 2).floor]
      @heading = 0
      mark_cell
    end

    def rotate_clockwise(change)
      @heading = ((@heading + change) % 360)
    end

    def rotate_counter_clockwise(change)
      rotate_clockwise(-change)
    end

    def move_forward(steps = 1)
      move(steps)
    end

    def move_backward(steps = 1)
      move(steps, true)
    end

    def to_s
      buffer = ''
      @board.each do |row|
        row.each do |cell|
          buffer << cell
        end
        buffer << "\n"
      end
      buffer
    end

    private

    def move(steps = 1, backward = false)
      move_vector = vector_from_heading
      move_vector = move_vector.collect { |v| - v } if backward

      steps.times do
        new_x = @pos[0] - move_vector[0]
        new_y = @pos[1] + move_vector[1]
        new_pos = [new_x, new_y]
        if valid_position? new_pos
          @pos = new_pos
          mark_cell
        end
      end
    end

    def valid_position?(position)
      @valid_range ||= (0...@board_size)
      @valid_range.include?(position[0]) && @valid_range.include?(position[1])
    end

    def mark_cell
      @board[@pos[0]][@pos[1]] = 'X'
    end

    def vector_from_heading(heading = @heading)
      heading_in_radians = heading * (Math::PI / 180)
      x = Math.cos(heading_in_radians).round(2)
      y = Math.sin(heading_in_radians).round(2)

      x = x > 0 ? x.ceil : x.floor
      y = y > 0 ? y.ceil : y.floor

      return [x, y]
    end

  end
end