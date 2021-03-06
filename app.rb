require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './image_upload.rb'
require 'sinatra/activerecord'
require './models'
require 'fileutils'

get '/' do
	erb :index
end

post '/image_upload' do


	# name = params[:images]['filename']# ファイル名の取得
	# kakutyousi = File.extname(name)#拡張子の取得

	# 画像アップロード
	names = image_upload_local(params[:images])
	# 画像アップロード後のファイルの中身取得

	# 画像アップロード前のファイルの中身取得
	before = Dir.glob("./public/image/*")


	file_path = Dir.glob("./public/original_image/*")[-1]
	puts file_path
	Image.create({file_name: file_path})
	original = Image.last
	# 外部コマンド実行
	command = "python detect.py #{file_path}"
	puts command
	system(command)

	now = Dir.glob("./public/image/*")

	# これでファイルのpathを無理やり取得
	files = now - before
	for file in files do
		Image.create({file_name: file, image_id: original.id})
	end
	file_path = files[0].to_s

	# puts before
	# puts now
	puts files


	#名前をdbにぶち込みたいので名前だけを抜き取る

	image = Image.create(
		file_name: file_path
	)
	id = Image.last.id

	file_path[0..16] = ""
	puts file_path
	for file in files
		Image.create({
			file_name: file,
			image_id: id
			})
	end

	# filesはリストだから各要素に対して実行する

	# path = ARGV[0]
	redirect '/image'
end

get '/image' do
	erb :image
end

get '/contact' do
	erb :contact
end

get '/view/:id' do
	@image = Image.find(params[:id])
	erb :view
end
# get '/image' do
# 	before = Dir.glob("./images/*")
# 	path = ARGV[0]
# 	system('python detect.py ' + path)
# 	erb :image
# end

# path = ARGV[0]
# system('python detect.py ' + path)