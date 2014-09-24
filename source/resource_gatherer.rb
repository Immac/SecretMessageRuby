require 'rubygems'
require 'rest-client'
require 'nokogiri'
require 'open-uri'
class ResourceGatherer
  def self.download_image(path,url)
    File.open(path, 'wb' ) do |output|
      output.write RestClient.get(url)
    end
  end
  def self.get_sources_from_url(url)
    page = Nokogiri::HTML(RestClient.get(url))
    img_sources = page.css('img').map{ |i| i['src'] }
  end
end