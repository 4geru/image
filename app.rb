require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './image_upload.rb'
require 'sinatra/activerecord'
require './models'

get '/' do
	erb :index
end
post '/image_upload' do
	image_upload_local(params[:images])
	redirect'/image'
end
get '/image' do
	erb :image
end
# path = ARGV[0]
# system('python detect.py ' + path)