# lib/currensees/historical.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Currensees
  class Historical
    BASE_URL = 'https://currensees.com/v1/historical'

    def self.get_historical_data(username, password, date, day, month, year)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}?username=#{username}&date=#{date}&day=#{day}&month=#{month}&year=#{year}")
      request = Net::HTTP::Get.new(uri, 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch historical data: #{response.code} #{response.message}"
      end
    end

    def self.get_historical_data_by_id(username, password, data_id, date_string, day, month, year)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{data_id}?username=#{username}&date_string=#{date_string}&day=#{day}&month=#{month}&year=#{year}")
      request = Net::HTTP::Get.new(uri, 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch historical data by ID: #{response.code} #{response.message}"
      end
    end
  end
end
