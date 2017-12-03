require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './image_upload.rb'
require 'sinatra/activerecord'
require './models'
require 'fileutils'
require "date"
get '/' do
	erb :index
end

post '/image_upload' do
	before = Dir.glob(".image/*")#画像アップロード前のファイルの中身取得
	name = params[:images]['filename']# ファイル名の取得
	kakutyousi = File.extname(name)#拡張子の取得
	image_upload_local(params[:images])#画像アップロード
	now = Dir.glob("./image/*")#画像アップロード後のファイルの中身取得
	file_path = now - before
	puts file_path
	system('python detect.py ', file_path.to_s)
	redirect'/'
end

get '/image' do
	before = Dir.glob("./images/*")
	path = ARGV[0]
	system('python detect.py ' + path)
	erb :image
end

# path = ARGV[0]
# system('python detect.py ' + path)