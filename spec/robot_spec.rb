require './robot'

describe Robot do
  subject { Robot.new }

  describe "PLACE" do
    context "invalid commands" do
      commands = [
        "PLACE0,0,NORTH",
        "PLACE 0,0,NORTH xxx",
        "PLACE 5,0,NORTH",
        "PLACE 0,0,N",
        "xPLACE 0,0,N",
      ]

      commands.each do |command|
        it "does not place the robot on the grid" do
          commands.each do |command|
            subject.respond(command)
            expect(subject.respond("REPORT")).to be_nil
          end
        end
      end
    end

    context "valid command" do
      it "places the robot on the grid" do
        subject.respond("PLACE 1,1,NORTH")
        expect(subject.respond("REPORT")).to eq("Output: 1,1,NORTH")
      end
    end
  end

  describe "RIGHT" do
    it "turns the robot to the right" do
      subject.respond("PLACE 1,1,NORTH")
      subject.respond("RIGHT")
      expect(subject.respond("REPORT")).to eq("Output: 1,1,EAST")
    end
  end
end
