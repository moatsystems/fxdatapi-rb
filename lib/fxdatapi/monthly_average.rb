# lib/fxdatapi/monthly_average.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Fxdatapi
  class MonthlyAverage
    BASE_URL = 'https://fxdatapi.com/v1/monthly_average'

    def self.get_monthly_average(username, password, year, month)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{year}/#{month}")
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)
      
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch monthly average data: #{response.code} #{response.message}"
      end
    end
  end
end
