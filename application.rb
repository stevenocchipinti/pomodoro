require 'sinatra'

notificationTime = nil;

get '/' do
  erb :index, :locals => { :notificationTime => notificationTime }
end

post '/' do
  notificationTime = params[:notificationTime]
end

get '/test' do
  require 'pusher'

  Pusher.app_id = 'APP_ID'
  Pusher.key = 'API_KEY'
  Pusher.secret = 'SECRET_KEY'

  Pusher['my-channel'].trigger('my-event', {:message => 'hello world'})
end
