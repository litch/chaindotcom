require 'json'

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
      faraday.request  :basic_auth, ENV['CHAIN_API_KEY'], ''
      faraday.response :logger     
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get "/v1/bitcoin/addresses/#{address.hash}"

    JSON.parse(response.body, symbolize_names: true)

  end

  def populate_values(address, remote_address)
    remote_address.each do |key, value|
      address.public_send("#{key}=", value)
    end
  end

end

