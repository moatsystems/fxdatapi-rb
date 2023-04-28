# lib/currensees/weekly_average.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Currensees
  class WeeklyAverage
    BASE_URL = 'https://currensees.com/v1/weekly_average'

    def self.get_weekly_average(username, password, from_date, to_date)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{from_date}/#{to_date}")
      request = Net::HTTP::Get.new(uri, 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch weekly average data: #{response.code} #{response.message}"
      end
    end
  end
end
