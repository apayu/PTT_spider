require 'net/http'
require 'cgi'
require 'nokogiri'

module Spider
  class Ptt
    def initialize(url)
      @url = url
    end

    def index
      url = URI.parse(@url)
      host, port = url.host, url.port if url.host && url.port
      req = Net::HTTP::Get.new(url.path, {
          "Cookie" => "over18=1;"
        })
      res = Net::HTTP.start(url.host, url.port, :use_ssl => true) do |http|
        http.request(req)
      end
      Nokogiri::HTML(res.body)
    end
  end
end
