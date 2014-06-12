require 'spec_helper'

describe Chaindotcom::AddressMapper do
  let(:address) { Chaindotcom::Address.new(hash: '1BZhjFc1ZnWXuSozoyM5V7sHsruCbrct1E') }

  it "will return a sane null address on an empty load" do
    VCR.use_cassette('unknown_address') do
      address.load
    end

    expect(address.balance).to eq 0
  end

  it "will return the reported address for a successful load" do
    VCR.use_cassette('known_address') do
      address.hash = '17x23dNjXJLzGMev6R63uyRhMWP1VHawKc'
      address.load
    end

    expect(address.balance).to eq(5000000000)
  end

end