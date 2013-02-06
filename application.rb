require 'sinatra'

get '/' do
  erb :index, :locals => {:notificationTime => params[:notificationTime]}
end
