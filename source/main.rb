require_relative 'encoder'
path = 'image.bmp'
url = 'http://perso.wanadoo.es/larigon2/fotos/charmander.bmp'
message = 'Be sure to drink your Ovaltine'
ResourceGatherer.download_image(path,url)
obj = Encoder.encode(path,message)
print obj