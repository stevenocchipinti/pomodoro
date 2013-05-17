require './lib/session'

describe Session do
  before do
    Session.class_variable_set(:@@sessions, {})
  end

  describe "#initialize" do
    it "sets the name and duration attributes to the given parameters" do
      session = Session.new("my-session", 1)
      session.name.should == "my-session"
      session.duration.should == 1
    end

    it "sets the connections attribute to an empty array" do
      session = Session.new("my-session", 1)
      session.connections.should == []
    end

    it "adds the new session object to a class-level hash of all sessions" do
      Session.class_variable_get(:@@sessions).should be_empty
      Session.new("new")
      Session.class_variable_get(:@@sessions).should have_key "new"
    end
  end

  describe "#start" do
    it "sets the notification_time to self.duration minutes from Time.now" do
      Time.stub(:now).and_return(5)                 # seconds
      session = Session.new("my-session", 1)        # minutes
      session.start
      session.notification_time.should == 65
    end
  end

  describe "#stop" do
    it "sets the notification_time to nil" do
      Time.stub(:now).and_return(5)                 # seconds
      session = Session.new("my-session", 1)        # minutes
      session.start
      session.notification_time.should_not be_nil
      session.stop
      session.notification_time.should be_nil
    end
  end


  describe "#to_hash" do
    subject { Session.new("my-session").to_hash }
    it { should have_key :duration }
    it { should have_key :time_left }
    it { should have_key :running }
  end

  describe "#to_json" do
    it "calls #to_json on the result of #to_hash" do
      session = Session.new("my-session")
      hash_mock = mock("hash")
      session.should_receive(:to_hash).and_return(hash_mock)
      hash_mock.should_receive(:to_json)
      session.to_json
    end
  end

  describe "#time_left" do
    before do
      Time.stub(:now).and_return(10)
    end
    let(:session) { Session.new("my-session") }

    it "returns nil if the notification_time is not set" do
      session.notification_time = nil
      session.time_left.should be_nil
    end

    it "returns zero if the notification_time has passed" do
      session.notification_time = 5
      session.time_left.should eq(0)
    end

    it "returns the number of seconds remaining before the notification_time" do
      session.notification_time = 25
      session.time_left.should eq(15)
    end

  end

  describe "#running?" do
    let(:session) { Session.new("my-session") }

    it "returns true when the notification time is in the future" do
      session.notification_time = Time.now + 60*2   # 2 minutes
      session.should be_running
    end

    it "returns false when the notification time is in the past" do
      session.notification_time = Time.now - 60*2   # 2 minutes
      session.should_not be_running
    end
    it "returns false when the notification time is nil" do
      session.notification_time = nil
      session.should_not be_running
    end
  end


  describe ".find_or_create" do
    it "returns the requested session if it exists" do
      session = mock(Session)
      Session.class_variable_set(:@@sessions, {"sesh" => session})
      Session.find_or_create("sesh").should eq(session)
    end

    it "returns a new session if the requested session does not exist" do
      Session.find_or_create("new-sesh").should be_a Session
    end
  end

  describe ".destroy" do
    it "removes the given session from the class-level hash of all sessions" do
      Session.new("foo")
      Session.all.should have(1).session
      Session.destroy("foo")
      Session.all.should have(0).sessions
    end
  end

end
