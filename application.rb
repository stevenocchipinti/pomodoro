require 'sinatra'

get '/' do
  erb :index, :locals => {:notificationTime => params[:notificationTime]}
end

post '/' do
  redirect "/?notificationTime=#{params[:notificationTime]}"
end
