class Robot
  def respond(command)
    if match = /^PLACE (?<x>[0-4]),(?<y>[0-4]),(?<f>NORTH|SOUTH|EAST|WEST)$/.match(command)
      place(match[:x], match[:y], match[:f])
    elsif command == "REPORT"
      report
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

  def report
    if placed?
      "Output: #{x},#{y},#{f}"
    end
  end
end
