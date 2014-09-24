require_relative 'encoder'
require_relative 'decoder'
require_relative 'resource_gatherer'
class Test
  def self.perform_encode
    path = 'image.bmp'
    message = '<*)))<{'
    puts Encoder.encode(path,message)
  end

  def self.perform_decode
    url = 'http://localhost/BitmapHtml/'
    counter = 0
    extension = '.bmp'
    path = 'image'
    message_list = Array.new
    url_list = ResourceGatherer.get_sources_from_url(url)
    url_list.each { |imgUrl|
      image_path = path + counter.to_s + extension
      ResourceGatherer.download_image(image_path,imgUrl)
      message_list << Decoder.decode(image_path)
      counter += 1
    }
    message_list
  end
end
Test.perform_encode
Test.perform_decode

