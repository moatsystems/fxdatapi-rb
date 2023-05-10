# lib/fxdatapi/performances.rb

# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'auth'

module Fxdatapi
  class Performances
    BASE_URL = 'https://fxdatapi.com/v1/performances'

    def self.get_performances(username, password)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}?username=#{username}")
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch performances: #{response.code} #{response.message}"
      end
    end

    def self.get_performance_by_id(username, password, performance_id)
      login_result = Authentication.login(username, password)
      cookie = "user_type=#{login_result['user_type']}; username=#{username}"

      uri = URI("#{BASE_URL}/#{performance_id}?username=#{username}")
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Cookie' => cookie)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Failed to fetch performance by ID: #{response.code} #{response.message}"
      end
    end
  end
end
