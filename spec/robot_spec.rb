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

  describe "turning left and right" do
    directions = {
      "NORTH" => "EAST",
      "EAST" => "SOUTH",
      "SOUTH" => "WEST",
      "WEST" => "NORTH",
    }

    describe "RIGHT" do
      directions.each do |current, expected|
        it "turns the robot to the right" do
          subject.respond("PLACE 1,1,#{current}")
          subject.respond("RIGHT")
          expect(subject.respond("REPORT")).to eq("Output: 1,1,#{expected}")
        end
      end
    end

    describe "LEFT" do
      directions.invert.each do |current, expected|
        it "turns the robot to the left" do
          subject.respond("PLACE 1,1,#{current}")
          subject.respond("LEFT")
          expect(subject.respond("REPORT")).to eq("Output: 1,1,#{expected}")
        end
      end
    end
  end

  describe "MOVE" do
    context "robot is on the edge of the grid" do
      placements = [
        "4,4,NORTH",
        "0,0,WEST",
        "0,0,SOUTH",
        "4,4,EAST",
      ]

      placements.each do |placement|
        it "does not move" do
          subject.respond("PLACE #{placement}")
          subject.respond("MOVE")
          expect(subject.respond("REPORT")).to eq("Output: #{placement}")
        end
      end
    end

    context "robot is not on the edge of the grid" do
      it "moves in the direction it is facing" do
        subject.respond("PLACE 0,0,NORTH")
        subject.respond("MOVE")
        expect(subject.respond("REPORT")).to eq("Output: 0,1,NORTH")
      end
    end
  end
end
