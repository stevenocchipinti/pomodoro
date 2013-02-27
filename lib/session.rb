class Session
  attr_accessor :name, :notification_time, :duration

  @@sessions = {}

  def initialize(name, notification_time=nil, duration=25)
    @name = name
    @notification_time = notification_time
    @duration = duration
    @@sessions[name] = self
  end

  def self.find(name=nil)
    name = "default" if !name || name.empty?
    @@sessions[name] || self.new(name)
  end

end
