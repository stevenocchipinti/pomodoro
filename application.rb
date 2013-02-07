require 'sinatra'

notificationTime = nil;

get '/' do
  erb :index, :locals => { :notificationTime => notificationTime }
end

post '/' do
  notificationTime = params[:notificationTime]
  redirect "/"
end
