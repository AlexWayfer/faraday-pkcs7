# frozen_string_literal: true

require 'pkcs7/cryptographer'

module Faraday
  module PKCS7
    # This class provides the main implementation for your middleware.
    # Your middleware can implement any of the following methods:
    # * on_request - called when the request is being prepared
    # * on_complete - called when the response is being processed
    #
    # Optionally, you can also override the following methods from Faraday::Middleware
    # * initialize(app, options = {}) - the initializer method
    # * call(env) - the main middleware invocation method.
    #   This already calls on_request and on_complete, so you normally don't need to override it.
    #   You may need to in case you need to "wrap" the request or need more control
    #   (see "retry" middleware: https://github.com/lostisland/faraday/blob/main/lib/faraday/request/retry.rb#L142).
    #   IMPORTANT: Remember to call `@app.call(env)` or `super` to not interrupt the middleware chain!
    class Middleware < Faraday::Middleware
      def initialize(app = nil, options = {})
        super

        @cryptographer = ::PKCS7::Cryptographer.new
      end

      # This method will be called when the request is being prepared.
      # You can alter it as you like, accessing things like request_body, request_headers, and more.
      # Refer to Faraday::Env for a list of accessible fields:
      # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
      #
      # @param env [Faraday::Env] the environment of the request being processed
      def on_request(env)
        ## Content can be encoded as XML (with corresponding header), so don't use `||=`
        env[:request_headers]['Content-Type'] = 'application/pkcs7-mime'
        encryption_method = options.fetch(:encrypt, true) ? :sign_and_encrypt : :sign
        env[:body] = @cryptographer.public_send(encryption_method, data: env[:body], **options[:encryption_options])
      end

      # This method will be called when the response is being processed.
      # You can alter it as you like, accessing things like response_body, response_headers, and more.
      # Refer to Faraday::Env for a list of accessible fields:
      # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
      #
      # @param env [Faraday::Env] the environment of the response being processed.
      def on_complete(env)
        decryption_method = options.fetch(:decrypt, true) ? :decrypt_and_verify : :verify
        env[:body] = @cryptographer.public_send(decryption_method, data: env[:body], **options[:decryption_options])
      end
    end
  end
end
