# Faraday PKCS7

[![Gem](https://img.shields.io/gem/v/faraday-pkcs7.svg?style=flat-square)](https://rubygems.org/gems/faraday-pkcs7)
[![License](https://img.shields.io/github/license/AlexWayfer/faraday-pkcs7.svg?style=flat-square)](LICENSE.md)

Faraday middleware for encryption and decryption PKCS7 containers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-pkcs7'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install faraday-pkcs7
```

## Usage

```ruby
require 'faraday/pkcs7'

client_cert = OpenSSL::X509::Certificate.new(File.read('path/to/cer_file'))
client_key = OpenSSL::PKey::RSA.new(File.read('path/to/key_file'), 'passphrase or empty string')

server_cert = OpenSSL::X509::Certificate.new(File.read('path/to/cer_file'))
cert_store = OpenSSL::X509::Store.new

Faraday.new(
  url: 'https://example.com/api/'
) do |faraday|
  faraday.use :pkcs7,
    encrypt: false,
    encryption_options: {
      key: client_key,
      certificate: client_cert,
      flags: OpenSSL::PKCS7::BINARY | OpenSSL::PKCS7::NOCERTS | OpenSSL::PKCS7::NOCHAIN
    },
    decrypt: false,
    decryption_options: {
      ca_store: cert_store,
      public_certificate: server_cert,
      flags: OpenSSL::PKCS7::NOVERIFY
    }
end
```

Options are optional, by default encryption and decryption are enabled. When disabled — there are only signing
without encryption and verifying without decryption.

For `encryption_options` and `decryption_options` see underlying gem: https://github.com/dmuneras/pkcs7-cryptographer

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/test` to run the tests.

To install this gem onto your local machine, run `rake build`.

To release a new version, make a commit with a message such as "Bumped to 0.0.2" and then run `rake release`.
See how it works [here](https://bundler.io/guides/creating_gem.html#releasing-the-gem).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/AlexWayfer/faraday-pkcs7).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
