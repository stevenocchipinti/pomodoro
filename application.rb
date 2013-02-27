require "sinatra"
require "pusher"

require "./lib/session"

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]


get "/*" do |session_name|
  session = Session.find(session_name)
  erb :index, :locals => {
    session_name: session.name,
    notification_time: session.notification_time,
    duration: session.duration
  }
end

post "/" do
  session = Session.find(params[:sessionName])
  session.duration = params[:duration]
  session.notification_time = params[:notificationTime]

  if session.notification_time.to_i > 0
    Pusher[session.name].trigger("start", session.to_hash)
  else
    Pusher[session.name].trigger("stop", {})
  end
end
