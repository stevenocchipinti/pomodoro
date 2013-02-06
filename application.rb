require 'sinatra'

get '/' do
  erb :index, :locals => {:countdown => params[:countdown]}
end
