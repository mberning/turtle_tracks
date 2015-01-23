require_relative File.join('..', 'lib', 'turtle_tracks')
require 'minitest/autorun'

class ParserTester < Minitest::Test
  def setup
    @parser = TurtleTracks::Parser.new
  end

  def test_parser_initialized
    assert_instance_of TurtleTracks::Parser, @parser
  end

  def test_parse_board_size
    parse = @parser.parse("61\n")
    assert_equal 61, parse[:board_size][:int].to_i
  end

  def test_parse_move_forward
    parse = @parser.parse("FD 1\n")
    assert_equal 'FD', parse[:move_forward].to_s
    assert_equal 1, parse[:int].to_i
  end

  def test_parse_move_backward
    parse = @parser.parse("BK 1\n")
    assert_equal 'BK', parse[:move_backward].to_s
    assert_equal 1, parse[:int].to_i
  end

  def test_parse_rotate_right
    parse = @parser.parse("RT 1\n")
    assert_equal 'RT', parse[:rotate_clockwise].to_s
    assert_equal 1, parse[:int].to_i
  end

  def test_parse_rotate_left
    parse = @parser.parse("LT 1\n")
    assert_equal 'LT', parse[:rotate_counter_clockwise].to_s
    assert_equal 1, parse[:int].to_i
  end

  def test_parse_repeat_single_command
    parse = @parser.parse("REPEAT 10 [ LT 45 ]\n")
    assert_equal 'REPEAT', parse[:repeat].to_s
    assert_equal 10, parse[:int].to_i
    actions = parse[:actions]
    action = actions[0]
    assert_equal 'LT', action[:rotate_counter_clockwise].to_s
    assert_equal 45, action[:int].to_i
  end

  def test_parse_repeat_many_commands
    parse = @parser.parse("REPEAT 10 [ LT 45 FD 20 RT 90 ]\n")
    assert_equal 'REPEAT', parse[:repeat].to_s
    assert_equal 10, parse[:int].to_i
    actions = parse[:actions]
    assert_equal 3, actions.length
  end
end
