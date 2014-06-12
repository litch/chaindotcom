require 'net/https'
require 'uri'
module Chaindotcom

  class ProjectInitializer

    def run
      url = URI.parse('https://chain.com/chain.pem.txt')

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      req = Net::HTTP::Get.new(url.path)
      res = http.request(req)

      FileUtils.mkdir_p('config')
      open("config/chain.pem", "w") do |file|
        file.write(res.body)
      end
    end
  end
end