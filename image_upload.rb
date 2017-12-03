require 'date'
def image_upload(img)
  logger.info "upload now"
  tempfile = img[:tempfile]
  
  upload = Cloudinary::Uploader.upload(tempfile.path)

  contents = User.last

  contents.update_attribute(:profile_image, upload['url'])
end

def image_upload_local(img)
  if img
    logger.info img
    ext = File.basename(img[:filename])
    kakutyoushi = File.extname(ext)
    t = Time.new
    times = t.strftime("%Y-%m-%d %H:%M:%S")
    img_name = "#{times + kakutyoushi}"
    puts img_name
    p "="*20
    logger.info ext
    img_path = "/images/#{img_name}"

    save_path = File.join('public', 'images', img_name)

    File.open(save_path, 'wb') do |f|
     logger.info "Temp file: #{img[:tempfile]}"
     f.write img[:tempfile].read
     logger.info 'アップロード成功'
    end
  else
    logger.info 'アップロード失敗'
  end
end
