# frozen_string_literal: true

require_relative 'pkcs7/middleware'
require_relative 'pkcs7/version'

module Faraday
  # This will be your middleware main module, though the actual middleware implementation will go
  # into Faraday::PKCS7::Middleware for the correct namespacing.
  module PKCS7
    # Faraday allows you to register your middleware for easier configuration.
    # This step is totally optional, but it basically allows users to use a
    # custom symbol (in this case, `:pkcs7`), to use your middleware in their connections.
    # After calling this line, the following are both valid ways to set the middleware in a connection:
    # * conn.use Faraday::PKCS7::Middleware
    # * conn.use :pkcs7
    # Without this line, only the former method is valid.
    Faraday::Middleware.register_middleware(pkcs7: Faraday::PKCS7::Middleware)

    # Alternatively, you can register your middleware under Faraday::Request or Faraday::Response.
    # This will allow to load your middleware using the `request` or `response` methods respectively.
    #
    # Load middleware with conn.request :pkcs7
    # Faraday::Request.register_middleware(pkcs7: Faraday::PKCS7::Middleware)
    #
    # Load middleware with conn.response :pkcs7
    # Faraday::Response.register_middleware(pkcs7: Faraday::PKCS7::Middleware)
  end
end
