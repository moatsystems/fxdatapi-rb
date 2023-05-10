# frozen_string_literal: true

require 'net/http'
require 'json'

module Fxdatapi
  class Authentication
    def self.login(username, password)
      uri = URI('https://fxdatapi.com/v1/login')
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json')

      request.body = {
        username: username,
        password: password,
      }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Login failed: #{response.code} #{response.message}"
      end
    end
  end
end
