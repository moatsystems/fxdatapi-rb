# lib/currensees/convert_all.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Currensees
  class ConvertAll
    BASE_URL = 'https://currensees.com/v1/convert_all'

    def self.convert_all(username, password, base_currency, amount, date)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI(BASE_URL)
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)

      request.body = {
        username: username,
        base_currency: base_currency,
        amount: amount,
        date: date,
      }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch conversion for all currencies: #{response.code} #{response.message}"
      end
    end
  end
end
