# robot.rb

require 'matrix'

class Game
  def initialize
    @table = table
  end

  def play(str)
    # PLACE 0,0,NORTH MOVE REPORT
    commands = str.gsub(/(PLACE\s[^\s]+|MOVE|REPORT)/)
    commands.each do |command|
      # PLACE 0,0,NORTH
      return send(command.downcase) unless command.match?(/PLACE/)

      # NORTH MOVE REPORT
      method_and_args = command.split
      method = method_and_args[0].downcase
      args   = method_and_args[1].split(',')
      send(method, *args)
    end
  end

  def place(x, y, f)
    puts 'placing'
    puts x
    puts y
    puts f
  end

  def move
    puts 'moving'
  end

  def left
    puts 'left'
  end

  def right
    puts 'right'
  end

  def report
    puts 'reporting'
  end

  private

  def table(x = 5, y = 5)
    Matrix.build(x, y) { nil }
    # Array.new(x) do |i|
    #   Array.new(y) do |i|
    #     {  }
    #   end
    # end
  end
end


# SW                       SE
# {x: 0, y: 0, f:}, {x: 0, y: 1, f:}, {x: 0, y: 2, f:}, {x: 0, y: 3, f:}, {x: 0, y: 4, f:}, 
# {x: 1, y: 0, f:}, {x: 1, y: 1, f:}, {x: 1, y: 2, f:}, {x: 1, y: 3, f:}, {x: 1, y: 4, f:}, 
# {x: 2, y: 0, f:}, {x: 2, y: 1, f:}, {x: 2, y: 2, f:}, {x: 2, y: 3, f:}, {x: 2, y: 4, f:}, 
# {x: 3, y: 0, f:}, {x: 3, y: 1, f:}, {x: 3, y: 2, f:}, {x: 3, y: 3, f:}, {x: 3, y: 4, f:}, 
# {x: 4, y: 0, f:}, {x: 4, y: 1, f:}, {x: 4, y: 2, f:}, {x: 4, y: 3, f:}, {x: 4, y: 4, f:},
# NW                       NE

# SW                       SE
# [0,0,][0,1,][0,2,][0,3,][0,4,]
# [1,0,][1,1,][1,2,][1,3,][1,4,]
# [2,0,][2,1,][2,2,][2,3,][2,4,]
# [3,0,][3,1,][3,2,][3,3,][3,4,]
# [4,0,][4,1,][4,2,][4,3,][4,4,]
# NW                       NE

# SE                       NE
# [
#   [nil, nil, nil, nil, nil], # 0, 4
#   [nil, nil, nil, nil, nil],
#   [nil, nil, nil, nil, nil],
#   [nil, nil, nil, nil, nil],
#   [nil, nil, nil, 'n', nil], # 4 , 3
# ]
# SW                       NW