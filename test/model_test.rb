require_relative File.join('..', 'lib', 'turtle_tracks')
require 'minitest/autorun'

class ModelTester < MiniTest::Unit::TestCase
  def setup
    @model = TurtleTracks::Model.new(11)
  end

  def test_model_initialized
    assert_kind_of TurtleTracks::Model, @model
    assert_equal 0, @model.heading
    assert_equal [5,5], @model.pos
    expected_state =
'...........
...........
...........
...........
...........
.....X.....
...........
...........
...........
...........
...........
'
    assert_equal expected_state, @model.to_s
  end

  def test_changing_heading_and_moving
    @model.rotate_clockwise(45)

    assert_equal 45, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward(2)
    assert_equal [3,7], @model.pos
    @model.move_backward(2)
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 90, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward
    assert_equal [5,6], @model.pos
    @model.move_backward
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 135, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward(2)
    assert_equal [7,7], @model.pos
    @model.move_backward(2)
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 180, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward
    assert_equal [6,5], @model.pos
    @model.move_backward
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 225, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward(2)
    assert_equal [7,3], @model.pos
    @model.move_backward(2)
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 270, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward
    assert_equal [5,4], @model.pos
    @model.move_backward
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 315, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward(2)
    assert_equal [3,3], @model.pos
    @model.move_backward(2)
    assert_equal [5,5], @model.pos

    @model.rotate_clockwise(45)
    assert_equal 0, @model.heading
    assert_equal [5,5], @model.pos
    @model.move_forward
    assert_equal [4,5], @model.pos
    @model.move_backward
    assert_equal [5,5], @model.pos

    expected_state =
'...........
...........
...........
...X...X...
....XXX....
....XXX....
....XXX....
...X...X...
...........
...........
...........
'
    assert_equal expected_state, @model.to_s
  end

  def test_edge_cases
    @model.reset
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.rotate_clockwise(90)
    @model.move_forward(100)

    expected_state =
'XXXXXXXXXXX
X.........X
X.........X
X.........X
X.........X
X....XXXXXX
X.........X
X.........X
X.........X
X.........X
XXXXXXXXXXX
'
    assert_equal expected_state, @model.to_s
  end

  def test_corner_cases
    @model.reset
    @model.rotate_clockwise(45)
    @model.move_forward(100)
    @model.move_backward(5)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.move_backward(5)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.move_backward(5)
    @model.rotate_clockwise(90)
    @model.move_forward(100)
    @model.move_backward(5)

    expected_state =
'X.........X
.X.......X.
..X.....X..
...X...X...
....X.X....
.....X.....
....X.X....
...X...X...
..X.....X..
.X.......X.
X.........X
'
    assert_equal expected_state, @model.to_s
  end

  def heading_tester(heading, expected_x, expected_y)
    model = TurtleTracks::Model.new(5)
    heading_vector = model.send(:vector_from_heading, heading)
    # x component should be expected_x
    assert_equal expected_x, heading_vector[0]
    # y component should be expected_y
    assert_equal expected_y, heading_vector[1]
  end

  def test_all_valid_headings
    heading_tester(0,     1,    0)
    heading_tester(45,    1,    1)
    heading_tester(90,    0,    1)
    heading_tester(135,   -1,   1)
    heading_tester(180,   -1,   0)
    heading_tester(225,   -1,   -1)
    heading_tester(270,   0,    -1)
    heading_tester(315,   1,    -1)
    heading_tester(360,   1,    0)
  end
end