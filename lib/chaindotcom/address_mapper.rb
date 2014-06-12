require 'faraday'
require 'json'

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

class Chaindotcom::AddressMapper
  def load(address)
    address.load_state = :loading

    remote_address = run_request(address)
    populate_values(address, remote_address)

    address.load_state = :loaded
  end

  private

  def run_request(address)
    Faraday::Request.register_middleware(username_only_auth: lambda { ::Faraday::Request::UsernameOnlyAuthentication })

    chain_cert = OpenSSL::X509::Certificate.new(File.read('config/chain.pem'))
    conn = Faraday.new( url: "https://api.chain.com",
                        ssl: {
                                client_cert: chain_cert
                              }) do |faraday|
      faraday.request  :username_only_auth, ENV['CHAIN_API_KEY']
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get "/v1/bitcoin/addresses/#{address.hash}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    if response.status == 500 && parsed_response[:message].match(/Unable to find address with hash/)
      {
        balance: 0,
        received: 0,
        sent: 0,
        unconfirmed_received: 0,
        unconfirmed_sent: 0,
        unconfirmed_balance: 0,
      }
    else
      parsed_response
    end

  end

  def populate_values(address, remote_address)
    remote_address.each do |key, value|
      address.public_send("#{key}=", value)
    end
  end

end

