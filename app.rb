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

	# 画像アップロード前のファイルの中身取得
	before = Dir.glob("./original_image/*")

	# name = params[:images]['filename']# ファイル名の取得
	# kakutyousi = File.extname(name)#拡張子の取得

	# 画像アップロード
	names = image_upload_local(params[:images])
	# 画像アップロード後のファイルの中身取得
	now = Dir.glob("./original_image/*")


	# これでファイルのpathを無理やり取得
	files = now - before
	file_path = files[0].to_s
	puts file_path

	# 外部コマンド実行
	command = "python detect.py #{file_path}"
	puts command
	system(command)

	#名前をdbにぶち込みたいので名前だけを抜き取る
	file_path[0..16] = ""
	puts file_path

	# filesはリストだから各要素に対して実行する
	image = Image.create(
		file_name: file_path
	)

	# path = ARGV[0]
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