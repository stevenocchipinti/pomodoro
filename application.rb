require "sinatra"
require "sinatra/contrib"
require "coffee_script"

require "./lib/session"


get "/js/*.js" do |filename|
  coffee "../public/js/#{filename}".to_sym
end


get "/" do
  if params[:session]
    session = Session.find_or_create(params[:session])
    erb :session, :locals => { session: session }
  else
    erb :index, :locals => { sessions: Session.all }
  end
end


# Stop and Start
post "/" do
  session = Session.find_or_create(params[:session][:name])
  if params[:session][:duration]
    session.duration = params[:session][:duration].to_i
  end

  session.start if params[:session][:action].downcase == "start"
  session.stop if params[:session][:action].downcase == "stop"

  # TODO: Notify the other connected clients
end


delete "/:name" do
  Session.destroy(params[:name])
  redirect "/"
end
