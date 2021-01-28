# robot.rb

require 'matrix'

class Game
  def initialize(rows = 5, cols = 5, north = :y)
    @table = { x: rows, y: cols, north: north }
    @position = { x: nil, x: nil, f: nil }
  end

  def play(str)
    commands = str.gsub(/(PLACE\s[^\s]+|MOVE|LEFT|RIGHT|REPORT)/)
    commands.map do |command|
      if command.match?(/PLACE/)
        method_and_args = command.split
        method = method_and_args[0].downcase
        args   = method_and_args[1].split(',')
        send(method, *args)
      else
        send(command.downcase)
      end
    end.last
  end

  def place(row, col, facing)
    @position[:x] = row.to_i
    @position[:y] = col.to_i
    @position[:f] = facing
  end

  def move
    case @position[:f]
    when 'NORTH'
      @position[:y] += 1 if @position[:y] < @table[:y]
    when 'EAST'
      @position[:x] += 1 if @position[:x] < @table[:x]
    when 'SOUTH'
      @position[:y] -= 1 if @position[:y].positive?
    when 'WEST'
      @position[:x] -= 1 if @position[:x].positive?
    end
  end

  def left
    case @position[:f]
    when 'NORTH'
      @position[:f] = 'WEST'
    when 'EAST'
      @position[:f] = 'NORTH'
    when 'SOUTH'
      @position[:f] = 'EAST'
    when 'WEST'
      @position[:f] = 'SOUTH'
    end
  end

  def right
    case @position[:f]
    when 'NORTH'
      @position[:f] = 'EAST'
    when 'EAST'
      @position[:f] = 'SOUTH'
    when 'SOUTH'
      @position[:f] = 'WEST'
    when 'WEST'
      @position[:f] = 'NORTH'
    end
  end

  def report
    "#{@position[:x]},#{@position[:y]},#{@position[:f]}"
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