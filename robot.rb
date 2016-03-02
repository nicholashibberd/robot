class Robot
  DIRECTIONS = %W(WEST NORTH EAST SOUTH)

  def respond(command)
    if match = /^PLACE (?<x>[0-4]),(?<y>[0-4]),(?<f>#{DIRECTIONS.join("|")})$/.match(command)
      place(match[:x], match[:y], match[:f])
    elsif command == "REPORT"
      report
    elsif command == "LEFT"
      turn_left
    elsif command == "RIGHT"
      turn_right
    end
  end

  private

  attr_reader :x, :y, :f

  def place(x, y, f)
    @x = x
    @y = y
    @f = f
  end

  def placed?
    x && y && f
  end

  def turn_right
    turn(DIRECTIONS)
  end

  def turn_left
    turn(DIRECTIONS.reverse)
  end

  def turn(directions)
    index = (directions.index(@f) + 1) % 4
    @f = directions[index]
  end

  def report
    if placed?
      "Output: #{x},#{y},#{f}"
    end
  end
end
