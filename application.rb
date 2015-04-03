require "sinatra"
require "sinatra/contrib"
require "sinatra/assetpack"
require "coffee-script"
require "sass"

require "./lib/session"


register Sinatra::AssetPack
assets do
  serve '/js',     from: 'public/js'
  serve '/css',    from: 'public/css'
  serve '/images', from: 'public/images'

  js :application, [
    '/js/lib/**/*.js',
    '/js/*.js'
  ]

  css :application, [
    '/css/**/*.css'
  ]

  js_compression  :jsmin
  css_compression :simple
end


get "/" do
  if params[:session]
    session = Session.find_or_create(params[:session])
    erb :session, :locals => { session: session }
  else
    erb :index, :locals => { sessions: Session.all }
  end
end


# Event Stream used to push updates
get '/stream/*', :provides => 'text/event-stream' do |session_name|
  stream :keep_open do |out|
    session = Session.find_or_create(session_name)
    session.connections << out
    out << "data: #{session.to_json}\n\n"
    out.callback { session.connections.delete(out) }
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

  # Notify the other connected clients
  session.connections.each { |out| out << "data: #{session.to_json}\n\n" }
  204 # response without entity body
end


delete "/:name" do
  Session.destroy(params[:name])
  redirect "/"
end
