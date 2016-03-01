require './robot'

describe Robot do
  subject { Robot.new }

  describe ".respond" do
    let(:command) { "some other command" }

    it "ignores erroneous commands" do
      expect(subject.respond(command)).to be_nil
    end
  end
end
