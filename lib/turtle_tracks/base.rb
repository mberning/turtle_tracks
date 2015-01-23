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
  end
end