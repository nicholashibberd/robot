require 'readline'
require './robot'

robot = Robot.new

while buf = Readline.readline("> ", true)
  if response = robot.respond(buf)
    p response
  end
end
