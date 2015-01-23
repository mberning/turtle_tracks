require 'parslet'

module TurtleTracks
  class Parser < Parslet::Parser

    rule(:space)            { match('\s').repeat(1) }
    rule(:space?)           { space.maybe }
    rule(:newline)          { match['\\n'] }
    rule(:newline?)         { newline.maybe }
    rule(:lbracket)         { str('[') >> space? }
    rule(:rbracket)         { space? >> str(']') >> space? }

    rule(:integer)          { match('[0-9]').repeat(1).as(:int) >> space? }

    rule(:rotate_cw)        { str('RT').as(:rotate_clockwise) >> space >> integer }
    rule(:rotate_ccw)       { str('LT').as(:rotate_counter_clockwise) >> space >> integer }
    rule(:rotate)           { rotate_cw | rotate_ccw }

    rule(:move_forward)     { str('FD').as(:move_forward) >> space >> integer }
    rule(:move_backward)    { str('BK').as(:move_backward) >> space >> integer }
    rule(:move)             { move_forward | move_backward }

    rule(:blank_line)       { (space? >> newline?).as(:noop) }
    rule(:board_size)       { integer.as(:board_size) >> space? >> newline? }
    rule(:action)           { move >> newline? | rotate >> newline? }
    rule(:repeat)           { str('REPEAT').as(:repeat) >> space >> integer >> (lbracket >> action.repeat(1).as(:actions) >> rbracket) >> newline? }
    rule(:expression)       { board_size | blank_line | action | repeat }

    root(:expression)
  end
end