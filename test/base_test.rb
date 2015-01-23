require_relative File.join('..', 'lib', 'turtle_tracks')
require 'minitest/autorun'

class BaseTest < Minitest::Test
  def test_run_simple_file
    file_name = File.expand_path(File.join('files', 'simple.logo'), File.dirname(__FILE__))
    TurtleTracks::Base.run_program_from_file(file_name)
  end

  def test_run_complex_file
    file_name = File.expand_path(File.join('files', 'complex.logo'), File.dirname(__FILE__))
    TurtleTracks::Base.run_program_from_file(file_name)
  end
end