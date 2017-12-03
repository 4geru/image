require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './image_upload.rb'
require 'sinatra/activerecord'
require './models'
require 'fileutils'
require "date"
require 'open3'
get '/' do
	erb :index
end

post '/image_upload' do
	before = Dir.glob("./original_image/*")#画像アップロード前のファイルの中身取得
	name = params[:images]['filename']# ファイル名の取得
	kakutyousi = File.extname(name)#拡張子の取得
	image_upload_local(params[:images])#画像アップロード
	now = Dir.glob("./original_image/*")#画像アップロード後のファイルの中身取得
	path = now - before
	command = "python detect.py #{path[0].to_s}"
	a = system(command)

	# なるほどわからん...
	image = Image.create(
		file_name: params[:file_name],
		)
	redirect '/'
end

# get '/image' do
# 	before = Dir.glob("./images/*")
# 	path = ARGV[0]
# 	system('python detect.py ' + path)
# 	erb :image
# end

# path = ARGV[0]
# system('python detect.py ' + path)