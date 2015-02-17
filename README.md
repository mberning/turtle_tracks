# An implementation of the turtle tracks puzzle in Ruby

## Run the tests
```
rake test
```

## Run the app

Jump in to irb
```
irb
```

Require the turtle tracks package
```
require_relative 'lib/turtle_tracks'
```

Run turtle tracks in interactive mode
```
TurtleTracks::Base.run_interactive
```

Run turtle tracks from command file
```
TurtleTracks::Base.run_program_from_file(file_name)
```