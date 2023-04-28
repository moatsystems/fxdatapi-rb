# lib/currensees/signals.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Currensees
  class Signals
    BASE_URL = 'https://currensees.com/v1/signals'

    def self.get_signals(username, password)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}?username=#{username}")
      request = Net::HTTP::Get.new(uri, 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch signals: #{response.code} #{response.message}"
      end
    end

    def self.get_signal_by_id(username, password, signal_id)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{signal_id}?username=#{username}")
      request = Net::HTTP::Get.new(uri, 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch signal by id: #{response.code} #{response.message}"
      end
    end
  end
end
