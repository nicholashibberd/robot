class Robot
  WEST = "WEST"
  NORTH = "NORTH"
  EAST = "EAST"
  SOUTH = "SOUTH"
  DIRECTIONS = [WEST, NORTH, EAST, SOUTH]

  def respond(command)
    if match = /^PLACE (?<x>[0-4]),(?<y>[0-4]),(?<f>#{DIRECTIONS.join("|")})$/.match(command)
      place(match[:x], match[:y], match[:f])
      nil
    elsif command == "REPORT"
      report if placed?
    elsif command == "LEFT"
      turn_left if placed?
      nil
    elsif command == "RIGHT"
      turn_right if placed?
      nil
    elsif command == "MOVE"
      move if placed?
      nil
    end
  end

  private

  attr_accessor :x, :y, :f

  def place(x, y, f)
    self.x = x.to_i
    self.y = y.to_i
    self.f = f
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
    index = (directions.index(f) + 1) % 4
    self.f = directions[index]
  end

  def move
    case f
    when NORTH then self.y += 1 unless y == 4
    when WEST then self.x -= 1 unless x == 0
    when SOUTH then self.y -= 1 unless y == 0
    when EAST then self.x += 1 unless x == 4
    end
  end

  def report
    "Output: #{x},#{y},#{f}"
  end
end
