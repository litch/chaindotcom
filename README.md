# Chaindotcom

This provides access to the (Chain.com)[https://chain.com/] API.

## Installation

Add this line to your application's Gemfile:

    gem 'chaindotcom'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chaindotcom

## Configuration:

  Running:

    $ chaindotcom

  From the command line will refresh the chain.pem file.  Do this if you'd like to ensure that you are using the certs.

## Usage

For more certainty on acutal usage, please see the spec files.  The following documentation is subject to become lies inadvertently...

  >> address = Chaindotcom::Address.new(hash: '1BZhjFc1ZnWXuSozoyM5V7sHsruCbrct1E')
  => #<Chaindotcom::Address:0x00000103623d98 @hash="1BZhjFc1ZnWXuSozoyM5V7sHsruCbrct1E", @data_source=#<Chaindotcom::AddressMapper:0x00000103623d20>>
  >> address.balance
  => 0

## Contributing

1. Fork it ( http://github.com/litch/chaindotcom/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
