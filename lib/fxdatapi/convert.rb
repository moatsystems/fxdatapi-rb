# lib/fxdatapi/convert.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Fxdatapi
  class Convert
    BASE_URL = 'https://fxdatapi.com/v1/convert'

    def self.convert_currency(username, password, date, base_currency, target_currency, amount)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI(BASE_URL)
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)
      request.body = {
        username: username,
        date: date,
        base_currency: base_currency,
        target_currency: target_currency,
        amount: amount,
      }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to convert currency: #{response.code} #{response.message}"
      end
    end
  end
end
