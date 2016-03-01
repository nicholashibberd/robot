robot = Robot.new

while buf = Readline.readline("> ", true)
  robot.respond(buf)
end
