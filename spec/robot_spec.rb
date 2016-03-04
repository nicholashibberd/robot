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
      context "before robot is placed" do
        it "ignores the command" do
          subject.respond("RIGHT")
          expect(subject.respond("REPORT")).to be_nil
        end
      end

      directions.each do |current, expected|
        it "turns the robot to the right" do
          subject.respond("PLACE 1,1,#{current}")
          subject.respond("RIGHT")
          expect(subject.respond("REPORT")).to eq("Output: 1,1,#{expected}")
        end
      end
    end

    describe "LEFT" do
      context "before robot is placed" do
        it "ignores the command" do
          subject.respond("LEFT")
          expect(subject.respond("REPORT")).to be_nil
        end
      end

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
    context "before robot is placed" do
      it "ignores the command" do
        subject.respond("MOVE")
        expect(subject.respond("REPORT")).to be_nil
      end
    end

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
      placements = {
        "0,0,NORTH" => "0,1,NORTH",
        "4,4,WEST" => "3,4,WEST",
        "4,4,SOUTH" => "4,3,SOUTH",
        "0,0,EAST" => "1,0,EAST",
      }

      placements.each do |original, expected|
        it "moves in the direction it is facing" do
          subject.respond("PLACE #{original}")
          subject.respond("MOVE")
          expect(subject.respond("REPORT")).to eq("Output: #{expected}")
        end
      end
    end
  end

  describe "end to end tests" do
    # testing the examples in the spec

    examples = [
      {
        commands: [
          "PLACE 0,0,NORTH",
          "MOVE"
        ],
        output: "Output: 0,1,NORTH"
      },
      {
        commands: [
          "PLACE 0,0,NORTH",
          "LEFT"
        ],
        output: "Output: 0,0,WEST"
      },
      {
        commands: [
          "PLACE 1,2,EAST",
          "MOVE",
          "MOVE",
          "LEFT",
          "MOVE",
        ],
        output: "Output: 3,3,NORTH"
      },
    ]

    examples.each do |example|
      it "executes every command and returns correct output" do
        example[:commands].each do |command|
          subject.respond(command)
        end
        expect(subject.respond("REPORT")).to eq(example[:output])
      end
    end
  end
end
