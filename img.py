import io
import urllib.request
from PIL import Image
f = io.BytesIO(urllib.request.urlopen("http://goddy-layout.com/wp-content/uploads/2017/06/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88-2017-06-24-14.40.45.png").read())
img = Image.open(f)