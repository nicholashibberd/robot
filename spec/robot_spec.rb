require './robot'

describe Robot do
  subject { Robot.new }

  describe ".respond" do
    describe "erroneous commands" do
      it "ignores them" do
        commands = [
          "PLACE0,0,NORTH",
          "PLACE 0,0,NORTH xxx",
          "PLACE 5,0,NORTH",
          "PLACE 0,0,N",
          "xPLACE 0,0,N",
          "Left",
          "R",
          "move"
        ]
        commands.each do |command|
          expect(subject.respond(command)).to be_nil
        end
      end
    end

    describe "commands" do
      context "robot has not been placed" do
        it "asks to be placed" do
          commands = %w(MOVE LEFT RIGHT REPORT)
          commands.each do |command|
            expect(subject.respond(command)).to eq("Please place the robot")
          end
        end
      end
    end
  end
end
