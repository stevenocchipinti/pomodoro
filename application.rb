require 'sinatra'
require 'pusher'

# TODO: Reset these keys (these are temp for dev so are ok in GitHub)
Pusher.app_id = '37160'
Pusher.key = '3521c8facdca5d505db3'
Pusher.secret = 'eb1a2ad84e2cda3a095f'

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
