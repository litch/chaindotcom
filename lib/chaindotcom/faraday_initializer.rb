require 'faraday'

module Faraday
  class Request::UsernameOnlyAuthentication < Request.load_middleware(:authorization)
    # Public
    def self.header(token, options = nil)
      value = Base64.encode64(token)
      value.gsub!("\n", '')
      super(:Basic, value)
    end

    def initialize(app, token, options = nil)
      super(app, token, options)
    end
  end
end