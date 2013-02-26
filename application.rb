require "sinatra"
require "pusher"

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]


get "/*" do |session_name|
  session = Session.find(session_name)
  # TODO: Use session.to_hash (beware of camel_case)
  erb :index, :locals => {
    session_name: session.name,
    notification_time: session.notification_time,
    duration: session.duration
  }
end

post "/" do
  session = Session.find(params[:sessionName])
  session.duration = params[:duration]
  session.notification_time = params[:noticationTime]
  if session.notification_time
    Pusher[session.name].trigger("start", session.to_hash)
  else
    Pusher[session.name].trigger("stop", {})
  end
end



class Session
  attr_accessor :name, :notification_time, :duration

  @@sessions = {}

  def initialize(name, notification_time=nil, duration=25)
    @name = name
    @notification_time = notification_time
    @duration = duration
    @@sessions[name] = self
  end

  # TODO: Use underscore stuff, make JS deal with RoR conventions?
  def to_hash
    {
      name: name,
      notificationTime: notification_time,
      duration: duration
    }
  end

  def self.find(name=nil)
    name = "default" if !name || name.empty?
    @@sessions[name] || self.new(name)
  end

end
