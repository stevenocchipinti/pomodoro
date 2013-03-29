require "sinatra"
require "pusher"
require "coffee_script"

require "./lib/session"
require "./lib/environment_variables"

EnvironmentVariables.validate!
Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]


get "/js/*.js" do |filename|
  coffee "../public/js/#{filename}".to_sym
end


get "/" do
  if params[:session]
    session = Session.find(params[:session])
    erb :session, :locals => {
      session_name: session.name,
      notification_time: session.notification_time,
      duration: session.duration
    }
  else
    erb :index, :locals => { sessions: Session.all }
  end
end


# Stop and Start
post "/" do
  session = Session.find(params[:session][:name])
  session.duration = params[:session][:duration]
  session.notification_time = params[:session][:notification_time]

  if session.notification_time.to_i > 0
    Pusher[session.name].trigger("start", session.to_hash)
  else
    Pusher[session.name].trigger("stop", {})
  end
end
