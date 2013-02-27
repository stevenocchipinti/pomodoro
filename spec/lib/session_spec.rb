require './lib/session'

describe Session do
  describe ".find" do

    before do
      Session.class_variable_set(:@@sessions, {})
    end

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
