require 'json'

class Session
  attr_accessor :name, :duration, :notification_time, :connections

  @@sessions = {}

  def initialize(name, duration=25)
    @name = name
    @duration = duration
    @connections = []
    @@sessions[self.class.to_key(name)] = self
  end

  def start
    @notification_time = Time.now + (@duration * 60)
  end

  def stop
    @notification_time = nil
  end


  def to_hash
    {
      duration: duration,
      time_left: time_left,
      running: running?
    }
  end

  def to_json
    to_hash.to_json
  end

  def time_left
    return nil unless notification_time
    seconds_left = (notification_time - Time.now).round
    seconds_left > 0 ? seconds_left : 0
  end

  def running?
    !!(notification_time && notification_time > Time.now)
  end


  def self.all
    @@sessions
  end

  def self.find_or_create(name)
    @@sessions[to_key(name)] || self.new(name)
  end

  def self.destroy(name)
    @@sessions.delete(to_key(name))
  end

  def self.to_key(name)
    name.upcase
  end

end
