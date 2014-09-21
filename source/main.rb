require_relative 'encoder'
require_relative 'decoder'
path = 'image.bmp'
out_path = 'imageout.bmp'
url = 'http://perso.wanadoo.es/larigon2/fotos/charmander.bmp'
message = 'Be sure to drink your Ovaltine'
ResourceGatherer.download_image(path,url)
puts Encoder.encode(path,message)
secret_message = Decoder.decode(out_path)
puts secret_message