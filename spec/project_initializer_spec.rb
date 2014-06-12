require 'spec_helper'

describe Chaindotcom::ProjectInitializer, isolated_directory: true do
  let(:command_line_config) { Chaindotcom::ProjectInitializer.new }

  it "downloads the certificate from chain.com" do
    VCR.use_cassette('certificate_download') do
      command_line_config.run
    end
  end

  it "writes the chain.pem file to config" do
    VCR.use_cassette('certificate_download') do
      command_line_config.run
    end
    expect(File.read('config/chain.pem')).to match(/BEGIN CERTIFICATE/m)
  end

end