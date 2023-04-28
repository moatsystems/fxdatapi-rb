# lib/currensees/margins_spreads.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Currensees
  class MarginsSpreads
    BASE_URL = 'https://currensees.com/v1/margins_spreads'

    def self.get_margins_spreads(username, password, day, month, year)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}?username=#{username}&day=#{day}&month=#{month}&year=#{year}")
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch margins and spreads: #{response.code} #{response.message}"
      end
    end

    def self.get_margin_spread_by_uuid(username, password, uuid, day, month, year)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{uuid}?username=#{username}&day=#{day}&month=#{month}&year=#{year}")
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch margin and spread by uuid: #{response.code} #{response.message}"
      end
    end
  end
end
