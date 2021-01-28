# game.rb
class Game
  def initialize(rows = 5, cols = 5)
    @table = { x: rows, y: cols }
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

  private

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
    turn(:left)
  end

  def right
    turn(:right)
  end

  def report
    "#{@position[:x]},#{@position[:y]},#{@position[:f]}"
  end

  def turn(side)
    points = {
      north: { left: :west, right: :east },
      east: { left: :north, right: :south },
      south: { left: :east, right: :west },
      west: { left: :south, right: :north }
    }
    @position[:f] = points[@position[:f].downcase.to_sym][side].to_s.upcase
  end
end
