require 'sinatra'
require 'pusher'

# TODO: Reset these keys (these are temp for dev so are ok in GitHub)
Pusher.app_id = '37160'
Pusher.key = '3521c8facdca5d505db3'
Pusher.secret = 'eb1a2ad84e2cda3a095f'

notification_time = nil;


get '/' do
  erb :index, :locals => { :notification_time => notification_time }
end

post '/' do
  notification_time = params[:notificationTime]
  if notification_time && !notification_time.empty?
    Pusher['events'].trigger("start", :notificationTime => notification_time)
  else
    Pusher['events'].trigger("stop", {})
  end
end
