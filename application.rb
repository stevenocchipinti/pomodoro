require 'sinatra'
require 'pusher'

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']

sessions = {
  "default" => nil
}


get '/*' do |session_name|
  session_name = "default" unless session_name && !session_name.empty?
  erb :index, :locals => {
    session_name: session_name,
    notification_time: sessions[session_name]
  }
end


post '/' do
  session_name = params[:sessionName]
  session_name = "default" unless session_name && !session_name.empty?
  sessions[session_name] = params[:notificationTime]
  if sessions[session_name] && !sessions[session_name].empty?
    Pusher[session_name].trigger("start", :notificationTime => sessions[session_name])
  else
    Pusher[session_name].trigger("stop", {})
  end
end
