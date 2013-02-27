require './lib/session'

describe Session do
  describe ".find" do
    it "returns the requested session if it exists"
    it "returns a new session if the requested session does not exist"
    it "returns the default session if no other session is requested"
  end
end
