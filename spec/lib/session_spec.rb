require './lib/session'

describe Session do
  before do
    Session.class_variable_set(:@@sessions, {})
  end

  describe "#initialize" do
    it "sets the name and duration attributes to the given parameters" do
      session = Session.new("my-session", 1)
      expect(session.name).to eq "my-session"
      expect(session.duration).to eq 1
    end

    it "sets the connections attribute to an empty array" do
      session = Session.new("my-session", 1)
      expect(session.connections).to eq []
    end

    it "adds the new session object to a class-level hash of all sessions" do
      expect(Session.class_variable_get(:@@sessions)).to be_empty
      Session.new("new")
      expect(Session.class_variable_get(:@@sessions)).not_to be_empty
    end

    it "creates a case insensitive hash key for session" do
      Session.new("new sesh")
      expect(Session.class_variable_get(:@@sessions)).to have_key "NEW SESH"
    end
  end

  describe "#start" do
    it "sets the notification_time to self.duration minutes from Time.now" do
      allow(Time).to receive(:now).and_return(5)    # seconds
      session = Session.new("my-session", 1)        # minutes
      session.start
      expect(session.notification_time).to eq 65
    end
  end

  describe "#stop" do
    it "sets the notification_time to nil" do
      allow(Time).to receive(:now).and_return(5)    # seconds
      session = Session.new("my-session", 1)        # minutes
      session.start
      expect(session.notification_time).not_to be_nil
      session.stop
      expect(session.notification_time).to be_nil
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
      hash_double = double("hash")
      expect(session).to receive(:to_hash).and_return(hash_double)
      expect(hash_double).to receive(:to_json)
      session.to_json
    end
  end

  describe "#time_left" do
    before do
      allow(Time).to receive(:now).and_return(10)
    end
    let(:session) { Session.new("my-session") }

    it "returns nil if the notification_time is not set" do
      session.notification_time = nil
      expect(session.time_left).to be_nil
    end

    it "returns zero if the notification_time has passed" do
      session.notification_time = 5
      expect(session.time_left).to eq(0)
    end

    it "returns the number of seconds remaining before the notification_time" do
      session.notification_time = 25
      expect(session.time_left).to eq(15)
    end

  end

  describe "#running?" do
    let(:session) { Session.new("my-session") }

    it "returns true when the notification time is in the future" do
      session.notification_time = Time.now + 60*2   # 2 minutes
      expect(session).to be_running
    end

    it "returns false when the notification time is in the past" do
      session.notification_time = Time.now - 60*2   # 2 minutes
      expect(session).not_to be_running
    end
    it "returns false when the notification time is nil" do
      session.notification_time = nil
      expect(session).not_to be_running
    end
  end


  describe ".find_or_create" do
    it "returns the requested session if it exists" do
      session = double(Session)
      Session.class_variable_set(:@@sessions, {"SESH" => session})
      expect(Session.find_or_create("SESH")).to eq(session)
    end

    it "uses case-insensitive matching to return the requested session" do
      session = double(Session)
      Session.class_variable_set(:@@sessions, {"SESH" => session})
      expect(Session.find_or_create("Sesh")).to eq(session)
    end

    it "returns a new session if the requested session does not exist" do
      expect(Session.find_or_create("new-sesh")).to be_a Session
    end
  end

  describe ".destroy" do
    it "removes the given session from the class-level hash of all sessions" do
      Session.new("foo")
      expect(Session.all.count).to eq(1)
      Session.destroy("foo")
      expect(Session.all.count).to eq(0)
    end
  end

end
