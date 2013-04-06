class Session
  attr_accessor :name, :notification_time, :duration

  @@sessions = {}

  def initialize(name, notification_time=nil, duration=25)
    @name = name
    @notification_time = notification_time
    @duration = duration
    @@sessions[name] = self
  end

  def to_hash
    {
      session: {
        name: name,
        notification_time: notification_time,
        duration: duration
      }
    }
  end

  def self.all
    @@sessions
  end

  def self.find(name=nil)
    name = "default" if !name || name.empty?
    @@sessions[name] || self.new(name)
  end

  def self.destroy(name)
    @@sessions.delete(name)
  end

end
