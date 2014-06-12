require 'spec_helper'

describe Chaindotcom::Address do
  let(:address) { Chaindotcom::Address.new(hash: '1BZhjFc1ZnWXuSozoyM5V7sHsruCbrct1E') }

  it "can hold a hash" do
    expect(address.hash).to eq('1BZhjFc1ZnWXuSozoyM5V7sHsruCbrct1E')
  end

  it "can load itself" do
    expect(address.data_source).to receive(:load)
    address.balance

  end


end
