require './lib/session'

describe Session do
  before do
    Session.class_variable_set(:@@sessions, {})
  end

  describe ".initialize" do
    let(:sessions) { Session.class_variable_get(:@@sessions) }

    it "adds the new session object to a class-level hash of all sessions" do
      expect{Session.find("new")}.to change{sessions.size}.by(1)
    end
  end

  describe ".find" do
    it "returns the requested session if it exists" do
      session = mock(Session)
      Session.class_variable_set(:@@sessions, {"sesh" => session})
      Session.find("sesh").should eq(session)
    end

    it "returns a new session if the requested session does not exist" do
      Session.find("new-sesh").name.should eq("new-sesh")
    end

    it "returns the default session if no other session is requested" do
      Session.find.name.should eq("default")
      Session.find("").name.should eq("default")
    end
  end
end
