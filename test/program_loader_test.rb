require_relative File.join('..', 'lib', 'turtle_tracks')
require 'minitest/autorun'

class ProgramLoaderTest < Minitest::Test
  def setup
    file_name = File.expand_path(File.join('files', 'complex.logo'), File.dirname(__FILE__))
    @loader = TurtleTracks::ProgramLoader.new(file_name)
  end

  def test_loader_initialized
    assert_instance_of TurtleTracks::ProgramLoader, @loader
  end

  def test_get_commands
    @loader.get_program
  end
end